{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    dunst
    libnotify
    rofi
    transmission_4-gtk
    youtube-music
    playerctl
    noto-fonts-cjk
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
