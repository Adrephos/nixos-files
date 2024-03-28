{ pkgs, inputs, outputs, lib, config, ... }:
let
  image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Adrephos/dotfiles/main/Pictures/Wallpaper/Dracula/EzQ53i7VoAMPd4h.jpeg";
    sha256 = "sha256-YpxWWc7VFJ9l/h4H23yDYHJkxrKV8cl7UKZw0i0tiTo=";
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
    blueman.enable = true;
    xserver = {
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          theme = "chili";
        };
        defaultSession = "xfce";
      };
      desktopManager = {
        # cinnamon.enable = true;
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status # gives you the default i3 status bar
          i3lock #default i3 screen locker
          i3-gaps
        ];
      };
      videoDrivers = ["nvidia"];
    };
    picom = {
      enable = true;
      settings = {
        corner-radius = 10;
        rounded-corners-exclude = [ "class_g = 'i3bar'" ];
      };
    };
  };

  programs = {
    steam.enable = true;
    noisetorch.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
    pulseaudio.enable = false;

    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };

    pulseaudio.extraConfig = "load-module module-combine-sink";
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
      
      prime = {
        sync.enable = true;

        amdgpuBusId = "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      boot.initrd.kernelModules = [ "amdgpu" ];
      services.xserver.videoDrivers = [ "amdgpu" ];
      hardware.nvidia = {};
    };
  };



  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    go

    cmake
    gnumake
    unzip

    # Haskell env
    stack
    cabal-install
    haskell-language-server
    ghc

    # Erlang
    gleam
    elixir

    # de juguete
    nodejs
    python3

    # La vida
    discord
    pavucontrol
    pulseaudio
    prismlauncher

    pkgs.haskellPackages.greenclip

    (sddm-chili-theme.override {
      themeConfig = {
        background = image;
      };
    })
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.stateVersion = "23.11";
}
