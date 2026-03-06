{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swww
    rofi
    xwayland-satellite
    playerctl
  ];
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
