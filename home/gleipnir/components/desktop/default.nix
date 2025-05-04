{ pkgs, ... }: {
  home.packages = with pkgs; [
    teams-for-linux
    brave
    chromium
    kdePackages.okular
    dunst
    libnotify
    rofi
    youtube-music
    playerctl
    noto-fonts-cjk-sans
    redshift
    anki-bin
    onedriver
    udiskie
    keepassxc
    xclip
    xxd
    psmisc
    gnumake
    flameshot
    transmission_4-gtk
    dbeaver-bin
    syncplay
  ];
}
