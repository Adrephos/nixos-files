{
  inputs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ./packages.nix
  ];

  # Hibernation
  boot.kernelParams = [ "resume=/dev/disk/by-label/swap" ];
  boot.resumeDevice = "/dev/disk/by-label/swap";

  # Droidcam
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];

  powerManagement.enable = true;

  services.logind.settings.Login = {
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
  };

  services.syncthing = {
    enable = true;
    user = "gleipnir";
    dataDir = "/home/gleipnir/.config/syncthing";
    configDir = "/home/gleipnir/.config/syncthing";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;
    guiPasswordFile = "/home/gleipnir/secrets/syncthing/passwd";
    settings = {
      gui = {
        user = "adrephos";
      };
      devices = {
        "phone" = {
          id = "TCD5MAE-PBCM7VY-YOANEUL-CCQJBCG-2HUKBAI-JTXQING-F5H4COG-QY7IPQO";
        };
      };
      folders = {
        "Notes" = {
          path = "/home/gleipnir/workspace/obsidian";
          devices = [ "phone" ];
        };
        "Pictures" = {
          path = "/run/media/gleipnir/IDK/Pictures";
          devices = [ "phone" ];
        };
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

      boot.blacklistedKernelModules = [
        "nouveau"
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
      ];
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
    "qtwebengine-5.15.19"
  ];

  nixpkgs.overlays = [
    inputs.templ.overlays.default
    inputs.claude-code.overlays.default
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  system.stateVersion = "23.11";
}
