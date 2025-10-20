{ pkgs, inputs, outputs, lib, config, ... }:
let
  sddm-theme = pkgs.fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "c10bd950544036c7418e0f34cbf1b597dae2b72f";
    sha256 = "sha256-ITufiMTnSX9cg83mlmuufNXxG1dp9OKG90VBZdDeMxw=";
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
    udisks2.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
      };
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        theme = "${sddm-theme}";
        extraPackages = with pkgs.kdePackages; [ qtmultimedia ];
      };
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };
    power-profiles-daemon.enable = true;
  };

  programs = {
    command-not-found.enable = true;
    dconf.enable = true;
    hyprland.enable = true;
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
  };

  hardware = {
    xone.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
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
      open = true;
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
  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
    "qtwebengine-5.15.19"
  ];

  nixpkgs.overlays = [
    inputs.templ.overlays.default
  ];

  environment.homeBinInPath = true;
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default


    # Java Zzzz
    jdk
    jdk11
    jdk21
    maven
    gradle

    #zig
    zig

    # Go
    go
    wgo
    templ

    # Development
    gcc
    cmake
    scrcpy
    simple-mtpfs
    gnumake
    linuxHeaders

    # Tools
    cargo
    nil
    rar
    unzip
    bruno
    postman
    openvpn
    ripgrep
    obsidian
    tree-sitter
    texlive.combined.scheme-full
    ghostscript
    python311Packages.pylatexenc
    nixpkgs-fmt
    networkmanager-openvpn

    # Utils
    file
    onlyoffice-desktopeditors
    # gpu-screen-recorder-gtk
    gpu-screen-recorder

    # owasp
    zap
    burpsuite

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
    stremio
    discord
    tidal-hifi
    pulseaudio
    pavucontrol
    prismlauncher

    # Wine & Gaming
    inputs.boosteroid.packages.x86_64-linux.boosteroid
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  system.stateVersion = "23.11";
}
