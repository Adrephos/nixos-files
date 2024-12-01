{ pkgs, ... }: {
  home.packages = with pkgs; [
    anki
    teams-for-linux
    obs-studio
    chromium
    okular
    dunst
    libnotify
    rofi
    transmission_4-gtk
    youtube-music
    playerctl
    noto-fonts-cjk-sans
    redshift
    anki
    onedriver
    udiskie
    keepassxc
    xclip
    xxd
    psmisc
    gnumake
    flameshot
  ];
}
