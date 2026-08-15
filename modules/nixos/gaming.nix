{ inputs, ... }:
{
  imports = [ inputs.boosteroid.nixosModules.default ];

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;

    gamescope = {
      enable = true;
      capSysNice = true;
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
