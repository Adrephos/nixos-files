{ pkgs, inputs, ... }:
let
  brave-previews = inputs.brave-previews;
in
{
  imports = [
    ./hyprland
    ./anki
  ];

  home.packages = with pkgs; [
    mpv
    teams-for-linux
    kdePackages.okular
    dunst
    libnotify
    # rofi
    networkmanagerapplet
    pear-desktop
    brave-previews.packages.${pkgs.stdenv.hostPlatform.system}.brave-beta
    # chromium
    # firefox
    playerctl
    pamixer
    noto-fonts-cjk-sans
    # redshift
    onedriver
    udiskie
    keepassxc
    xclip
    wl-clipboard
    xxd
    psmisc
    gnumake
    transmission_4-gtk
    syncplay
  ];
}
