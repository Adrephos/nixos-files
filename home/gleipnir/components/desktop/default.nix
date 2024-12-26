{ pkgs, ... }: {
  home.packages = with pkgs; [
    teams-for-linux
    obs-studio
    chromium
    okular
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
  ];
}
