{ pkgs, ... }:
{
  networking = {
    hostName = "vin";

    firewall = {
      enable = false;
      allowedTCPPorts = [
        8384
        22000
      ];
      allowedUDPPorts = [
        22000
        21027
      ];
    };

    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
  };
}
