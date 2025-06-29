{ pkgs, ... }: {
  imports = [
    ./git
    ./fish
    ./yazi
    ./starship
  ];

  home.packages = with pkgs; [
    eza
    zoxide
    p7zip
    btop
    ncdu
    bat
    socat
    jq
    neofetch
    cmatrix
    brightnessctl
    fzf
    onefetch
    wget
    feh
    timer
    lolcat
    glow
    google-cloud-sdk-gce
    clipboard-jh
    xdragon
  ];
}
