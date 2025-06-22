{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./fish.nix
    ./yazi.nix
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
  ];
}
