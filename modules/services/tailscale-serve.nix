{ config, pkgs, ... }:
{
  systemd.services.tailscale-serve = {
    description = "Tailscale serve (HTTPS proxies)";
    wantedBy = [ "multi-user.target" ];
    after = [
      "tailscaled.service"
      "tailscaled-autoconnect.service"
      "network-online.target"
    ];
    wants = [ "network-online.target" ];
    requires = [ "tailscaled.service" ];
    path = [ config.services.tailscale.package ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = 10;
    };
    script = ''
      tailscale serve --bg --https=443 http://127.0.0.1:8096
      tailscale serve --bg --https=8443 http://127.0.0.1:${toString config.services.suwayomi-server.settings.server.port}
    '';
  };
}
