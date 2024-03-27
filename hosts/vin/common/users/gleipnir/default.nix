{ pkgs, config, ... }: {
  users.users.gleipnir = {
    isNormalUser = true;
    description = "No tengo idea";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = [
      pkgs.home-manager
    ];
  };

  home-manager.users.gleipnir = import ../../../../../home/gleipnir/${config.networking.hostName}.nix;
}
