{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprshot
    gtk3
    wl-clipboard
    wl-mirror
    awww
    rofi
    xwayland-satellite
    playerctl
  ];

  home.sessionVariables.HYPRSHOT_DIR = "/home/${config.home.username}/Pictures/Screenshots";

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
}
