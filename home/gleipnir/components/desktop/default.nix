{ pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    dunst
    libnotify
    rofi
    transmission_4-gtk
    youtube-music
    anki
  ];
}
