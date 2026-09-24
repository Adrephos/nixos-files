{ pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  fonts.packages = [ pkgs.noto-fonts-cjk-sans ];
}
