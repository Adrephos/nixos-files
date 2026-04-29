{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    wl-mirror
    awww
    rofi
    xwayland-satellite
    playerctl
  ];
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
