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
    firewall.enable = false;
    hostName = "vin";
    networkmanager.enable = true;
  };

  boot.loader.grub = {
    theme = pkgs.stdenv.mkDerivation {
      pname = "sekiro_grub_theme";
      version = "1.0";
      src =pkgs.fetchFromGitHub {
        owner = "semimqmo";
        repo = "sekiro_grub_theme";
        rev = "1affe05f7257b72b69404cfc0a60e88aa19f54a6";
        hash = "sha256-wTr5S/17uwQXkWwElqBKIV1J3QUP6W2Qx2Nw0SaM7Qk=";
      };
      installPhase = "cp -r Sekiro $out";
    };
    configurationLimit = 5;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    xserver = {
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
      enable = true;
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
          i3status
          i3lock
          i3-gaps
        ];
      };
      videoDrivers = ["nvidia"];
    };
    displayManager = {
      sddm = {
        enable = true;
        theme = "chili";
      };
      defaultSession = "xfce";
    };
    picom = {
      enable = true;
      settings = {
        corner-radius = 10;
        rounded-corners-exclude = [ "class_g = 'i3bar'" ];
      };
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT1 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging
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
      setLdLibraryPath = true;

      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
    pulseaudio.enable = false;

    opentabletdriver.enable = true;

    bluetooth = {
      enable = false; # enables support for Bluetooth
      powerOnBoot = false; # powers up the default Bluetooth controller on boot
    };

    pulseaudio.extraConfig = "load-module module-combine-sink";
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = true;
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

  # virtualbox
  virtualisation.virtualbox.host.enable = true;

  environment.homeBinInPath = true;
  environment.systemPackages = with pkgs; [
    go

    cmake
    gnumake
    unzip

    # Tools
    obsidian
    postman
    openvpn
    networkmanager-openvpn

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
    python311Packages.pip

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
