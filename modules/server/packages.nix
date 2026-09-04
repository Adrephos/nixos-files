{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    htop
    jq
    just
    nh
    neovim
    ripgrep
    tmux
    tree
    unzip
    wget
    yazi
  ];

  programs = {
    bash.completion.enable = true;
    git.enable = true;
  };
}
