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
    mpv
    feh
    zellij
    (nnn.override { withNerdIcons = true; })
  ];
}
