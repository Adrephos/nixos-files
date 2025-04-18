{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./fish.nix
  ];

  home.packages = with pkgs; [
    eza
    thefuck
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
    google-cloud-sdk-gce
    (nnn.override { withNerdIcons = true; })
  ];
}
