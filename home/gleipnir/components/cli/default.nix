{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./fish.nix
  ];

  home.packages = with pkgs; [
    eza
    thefuck
    zoxide
    neovim
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
    # zellij
    google-cloud-sdk-gce
    (nnn.override { withNerdIcons = true; })
  ];
}
