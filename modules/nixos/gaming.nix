{ inputs, pkgs, ... }:
{
  imports = [ inputs.boosteroid.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    lsfg-vk
    lsfg-vk-ui
  ];

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;

    gamescope = {
      enable = true;
      capSysNice = false;
    };

    boosteroid = {
      enable = true;
      videoDecoder = "vaapi";
      extraEnv = {
        LIBVA_DRIVER_NAME = "radeonsi";
        LIBVA_DRIVERS_PATH = "/run/opengl-driver/lib/dri";
        LD_LIBRARY_PATH = "/run/opengl-driver/lib";
      };
    };
  };
}
