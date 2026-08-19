{
  config,
  lib,
  pkgs,
  ...
}:
{
  hardware = {
    keyboard.zsa.enable = true;
    xone.enable = true;
    opentabletdriver.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        libva
        libva-utils
        nvidia-vaapi-driver
      ];
    };

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
        offload.enable = true;
        offload.enableOffloadCmd = true;
        sync.enable = false;
        amdgpuBusId = "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  environment.variables = {
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
      "/run/opengl-driver"
    ];
  };
}
