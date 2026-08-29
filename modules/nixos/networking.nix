{ pkgs, ... }:
{
  imports = [ ../shared/networking.nix ];

  networking = {
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

    networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
  };
}
