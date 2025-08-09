{ pkgs, ... }: {
  imports = [
    ./git
    ./fish
    ./yazi
    ./starship
    ./tmux
    ./kitty
    # ./ghostty
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
    fastfetch
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
  ];
}
