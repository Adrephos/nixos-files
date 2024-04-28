{ pkgs, config, ... }: {
  users.users.gleipnir = {
    isNormalUser = true;
    description = "No tengo idea";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = [
      pkgs.home-manager
    ];
  };

  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  home-manager.users.gleipnir = import ../../../../../home/gleipnir/${config.networking.hostName}.nix;
}
