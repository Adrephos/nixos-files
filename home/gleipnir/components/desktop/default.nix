{ pkgs, ... }: {
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
    youtube-music
    chromium
    firefox
    playerctl
    pamixer
    noto-fonts-cjk-sans
    # redshift
    anki-bin
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
