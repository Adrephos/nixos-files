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
    configurationLimit = 3;
  };

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    xserver = {
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
      enable = true;
      desktopManager = {
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
      windowManager.bspwm.enable = true;
      videoDrivers = ["nvidia"];
    };
    displayManager = {
      sddm = {
        enable = true;
        theme = "chili";
      };
      defaultSession = "xfce+i3";
    };
    picom = {
      enable = true;
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };
    power-profiles-daemon.enable = true;
  };

  programs = {
    adb.enable = true;
    steam.enable = true;
    noisetorch.enable = true;
    nix-ld.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      # driSupport = true;
      enable32Bit = true;
      # setLdLibraryPath = true;

      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
    pulseaudio.enable = false;

    opentabletdriver.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    # pulseaudio.extraConfig = "load-module module-combine-sink";
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      open = false;
      nvidiaSettings = true;

      modesetting.enable = true;

      powerManagement.enable = true;
      powerManagement.finegrained = false;

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

      boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';

      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';

      boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
    };
  };

  virtualisation.docker.enable = true;

  # virtualbox
  virtualisation.virtualbox.host.enable = true;

  environment.homeBinInPath = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-29.4.6" ];
  environment.systemPackages = with pkgs; [
    # Java Zzzz
    jdk
    jdk11
    jdk22
    jetbrains.idea-community
    gradle

    # Development
    go
    gcc
    scrcpy
    linuxHeaders
    cmake
    gnumake

    # Tools
    wineWowPackages.stable
    unzip
    bruno
    obsidian
    openvpn
    networkmanager-openvpn
    gpu-screen-recorder-gtk

    # Learning
    exercism

    # Scala
    sbt
    scala
    scala-cli
    ammonite
    scalafmt

    # Haskell env
    stack
    cabal-install
    haskell-language-server
    # ghc
    haskell.compiler.ghc810


    # Erlang
    gleam
    elixir

    # de juguete
    nodejs
    python3
    python311Packages.pip

    # La vida
    stremio
    discord
    vesktop
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
  system.autoUpgrade.allowReboot = true;

  system.stateVersion = "23.11";
}
