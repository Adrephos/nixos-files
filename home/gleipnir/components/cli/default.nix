{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./fish.nix
  ];

  home.packages = with pkgs; [
    tree
    neovim
    p7zip
    htop
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
    (nnn.override { withNerdIcons = true; })
  ];
}
