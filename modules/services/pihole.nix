{ pkgs, ... }:
{
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    lists = [
      {
        url = "file://${pkgs.stevenblack-blocklist}/hosts";
        description = "Steven Black's unified adlist";
      }
    ];
    settings = {
      misc.readOnly = false;
      dns = {
        domainNeeded = true;
        expandHosts = true;
        listeningMode = "ALL";
        upstreams = [ "1.1.1.1" "9.9.9.9" ];
      };
    };
  };

  services.pihole-web = {
    enable = true;
    ports = [ 80 ];
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
