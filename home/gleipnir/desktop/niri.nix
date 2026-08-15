{ pkgs, ... }:
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
}
