{ pkgs, ... }:
{
  home.packages = with pkgs; [
    eza
    zoxide
    p7zip
    btop
    ncdu
    bat
    socat
    jq
    fastfetch
    brightnessctl
    fzf
    onefetch
    wget
    loupe
    feh
    timer
    lolcat
    glow
    google-cloud-sdk-gce
    gum
    ueberzugpp
    posting
    lazygit
    lazysql
    gopls
    gcc

    # Fonts
    nerd-fonts.jetbrains-mono
    librsvg
    awatcher
  ];
}
