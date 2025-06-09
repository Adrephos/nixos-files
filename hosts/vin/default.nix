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

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    pulseaudio.enable = false;
    # clamav.daemon.enable = true;
    # clamav.updater.enable = true;
    xserver = {
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
      enable = true;
      desktopManager = {
        runXdgAutostartIfNone = true;
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
          enableScreensaver = false;
        };
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock-color
          i3-gaps
        ];
      };
      windowManager.bspwm.enable = true;
      videoDrivers = [ "nvidia" ];
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
    tumbler.enable = true;
  };

  programs = {
    dconf.enable = true;
    adb.enable = true;
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    nix-ld.enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
    ];
    xfconf.enable = true;
    file-roller.enable = true;
  };

  hardware = {
    xone.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };

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

    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia = {
      open = false;
      nvidiaSettings = true;

      modesetting.enable = true;

      powerManagement.enable = true;
      powerManagement.finegrained = false;

      package = config.boot.kernelPackages.nvidiaPackages.latest;

      prime = {
        offload.enable = false;
        sync.enable = true;
        amdgpuBusId = "PCI:5:0:0";
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

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
  ];

  nixpkgs.overlays = [
    inputs.templ.overlays.default
  ];

  environment.homeBinInPath = true;
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default

    # Security
    # clamav

    # Java Zzzz
    jdk
    jdk11
    jdk21
    gradle
    maven
    jetbrains.idea-community-bin

    #zig
    zig

    # Go
    go
    wgo
    templ

    # Development
    gcc
    scrcpy
    linuxHeaders
    cmake
    gnumake

    # Tools
    unzip
    bruno
    postman
    obsidian
    openvpn
    networkmanager-openvpn
    xarchiver
    ripgrep
    nil
    nixpkgs-fmt

    # Utils
    anydesk
    gpu-screen-recorder-gtk
    gpu-screen-recorder

    # Learning
    exercism
    python312Packages.manga-ocr

    # Erlang
    gleam
    elixir

    # de juguete
    pnpm
    nodejs
    python3
    python311Packages.pip

    # La vida
    slack
    stremio
    discord
    pulseaudio
    pavucontrol
    prismlauncher

    haskellPackages.greenclip

    # Wine & Gaming
    lm_sensors
    mangohud
    winetricks
    wineWowPackages.stable

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
