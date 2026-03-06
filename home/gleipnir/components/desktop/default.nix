{ pkgs, inputs, ... }:
let
  brave-packages = inputs.brave-previews.packages.${pkgs.stdenv.hostPlatform.system};
  brave-beta = brave-packages.brave-beta;
  brave-nightly = brave-packages.brave-nightly;
in
{
  imports = [
    ./hyprland
    ./niri
    ./anki
  ];

  home.packages = with pkgs; [
    mpv
    teams-for-linux
    kdePackages.okular
    dunst
    libnotify
    networkmanagerapplet
    pear-desktop
    brave-beta
    brave-nightly
    playerctl
    pamixer
    noto-fonts-cjk-sans
    onedriver
    udiskie
    keepassxc
    xclip
    wl-clipboard
    xxd
    psmisc
    gnumake
    transmission_4-gtk
  ];
}
