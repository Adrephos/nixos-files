{
  config,
  pkgs,
  ...
}:
let
  domain = "adrephos.com";
  tsName = "elend.tailb3a379.ts.net";
  tsCertDir = "/var/lib/tailscale-cert";

  proxy = port: {
    useACMEHost = domain;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString port}";
      proxyWebsockets = true;
    };
  };
in
{
  # Wildcard cert through the DNS-01 challenge, so nothing has to be reachable from the internet.
  # Put a Cloudflare API token (Zone:DNS:Edit on adrephos.com) alone in /etc/nixos-secrets/acme-cloudflare.
  security.acme = {
    acceptTerms = true;
    certs.${domain} = {
      domain = "*.${domain}";
      dnsProvider = "cloudflare";
      # elend's system resolver is MagicDNS, which caches NXDOMAIN for the challenge record.
      dnsResolver = "1.1.1.1:53";
      credentialFiles.CLOUDFLARE_DNS_API_TOKEN_FILE = "/etc/nixos-secrets/acme-cloudflare";
      group = config.services.nginx.group;
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;

    virtualHosts = {
      "jellyfin.${domain}" = proxy 8096;
      "manga.${domain}" = proxy config.services.suwayomi-server.settings.server.port;
      "pihole.${domain}" = proxy 8081;

      ${tsName} = {
        forceSSL = true;
        sslCertificate = "${tsCertDir}/cert.pem";
        sslCertificateKey = "${tsCertDir}/key.pem";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
          proxyWebsockets = true;
        };
      };
    };
  };

  # Certificate for the ts.net name, issued by Tailscale (needs HTTPS certificates enabled in the
  # tailnet admin console). Falls back to a self-signed one so nginx can always start.
  systemd.services.tailscale-cert = {
    description = "Fetch the Tailscale HTTPS certificate for ${tsName}";
    wantedBy = [ "multi-user.target" ];
    before = [ "nginx.service" ];
    after = [
      "tailscaled.service"
      "network-online.target"
    ];
    wants = [ "network-online.target" ];
    path = [
      config.services.tailscale.package
      pkgs.openssl
      pkgs.systemd
    ];
    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = tsCertDir;
    };
    script = ''
      if ! tailscale cert --cert-file cert.pem --key-file key.pem ${tsName}; then
        echo "tailscale cert failed; keeping any existing certificate" >&2
        [ -e cert.pem ] || openssl req -x509 -newkey rsa:2048 -nodes -days 30 \
          -subj "/CN=${tsName}" -keyout key.pem -out cert.pem
      fi
      chgrp ${config.services.nginx.group} cert.pem key.pem
      chmod 640 cert.pem key.pem
      # --no-block: this unit is ordered before nginx, so waiting on it would deadlock at boot.
      systemctl --no-block try-reload-or-restart nginx.service
    '';
  };

  # tmpfiles, not StateDirectory, which would reset the group to root on every start.
  systemd.tmpfiles.rules = [ "d ${tsCertDir} 0750 root ${config.services.nginx.group} - -" ];

  systemd.services.nginx = {
    wants = [ "tailscale-cert.service" ];
    after = [ "tailscale-cert.service" ];
  };

  systemd.timers.tailscale-cert = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
