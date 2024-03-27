{ pkgs, inputs, outputs, ... }:
let
  image = pkgs.fetchurl {
    url = "https://github.com/Adrephos/dotfiles/blob/main/Pictures/Wallpaper/Dracula/995185.png";
    sha256 = lib.fakeSha256;
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ./common/users/gleipnir
    ./common/generic

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  networking = {
    #firewall.enable = false;
    hostName = "vin";
    networkmanager.enable = true;
  };

  boot.loader.grub.minegrub-theme.enable = true;

  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          theme = "chili";
        };
      };
      desktoManager.cinnamon.enable = true;
      windowManager.dwm.enable = true;
    };
  };

  programs = {
    steam.enable = true;
    noisetorch.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    go

    cmake
    unzip

    # Haskell env
    stack
    cabal-install
    haskell-language-server

    # Erlang
    gleam
    elixir

    # de juguete
    nodejs
    python

    # La vida
    discord
    prismlauncher
    (sddm-chili-theme.override {
      themeConfig = {
        background = image;
      };
    })
  ];

  system.stateVersion = "23.11";
}
