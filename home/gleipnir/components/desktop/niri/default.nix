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
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
