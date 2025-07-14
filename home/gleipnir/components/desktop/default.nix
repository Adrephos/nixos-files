{ pkgs, ... }: {
  imports = [
    ./hyprland
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
    dbeaver-bin
    syncplay
  ];
}
