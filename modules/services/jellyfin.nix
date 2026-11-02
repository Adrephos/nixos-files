{ pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  fonts.packages = [ pkgs.noto-fonts-cjk-sans ];
}
