{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users.gleipnir = {
    isNormalUser = true;
    description = "ヴァイオレット・エヴァーガーデン";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "adbusers"
    ];
    packages = [
      pkgs.home-manager
    ];
  };

  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users.gleipnir = import ../../home/gleipnir;
  };
}
