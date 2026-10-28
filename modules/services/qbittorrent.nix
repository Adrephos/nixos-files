{ inputs, ... }:
{
  imports = [ inputs.vpn-confinement.nixosModules.default ];

  # Proton WireGuard config lives outside the store: /etc/wireguard/proton.conf (root:root, 600)
  vpnNamespaces.proton = {
    enable = true;
    wireguardConfigFile = "/etc/wireguard/proton.conf";
    accessibleFrom = [ "192.168.0.0/16" ];
    portMappings = [
      {
        from = 8080;
        to = 8080;
      }
    ];
  };

  services.qbittorrent = {
    enable = true;
    webuiPort = 8080;
    torrentingPort = 6881;
    openFirewall = false;
  };

  systemd.services.qbittorrent = {
    vpnConfinement = {
      enable = true;
      vpnNamespace = "proton";
    };
    serviceConfig = {
      SupplementaryGroups = [ "media" ];
      UMask = "0002";
    };
  };
}
