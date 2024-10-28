{ config, pkgs, ... }:
let
  catppuccin-fish = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    hash = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
  };
in
{
  home.file = {
    ".config/fish/themes/Catppuccin Macchiato.theme".source = "${catppuccin-fish}/themes/Catppuccin Macchiato.theme";
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --color=always --git --icons=always --no-time --no-user --no-permissions -a";
      ll = "eza --color=always --long --git --icons=always -la";
      tree = "eza --tree";
      nnn = "nnn -d -e -H -r";
      cat = "bat --theme Dracula";
      venv = "source venv/bin/activate.fish";
      ssh = "env TERM=xterm-256color ssh";
      dot = "git --git-dir=$HOME/dotfiles/ --work-tree=$HOME";
    };
    interactiveShellInit = ''
      set -U fish_greeting
      fish_config theme choose Catppuccin\ Macchiato
      fish_config prompt choose astronaut

      set kitty_count (pgrep -c -f "kitty")

      if test $kitty_count -eq 1
        neofetch --kitty /home/${config.home.username}/Pictures/onefetch/asuka.png --size 375px
      end

      function cd
        z $argv
        set git_root (git rev-parse --show-toplevel 2>/dev/null)

        if test -n "$git_root"
          if test "$git_root" != "$last_git_root"
            clear
            onefetch -d dependencies authors contributors license -i /home/${config.home.username}/Pictures/onefetch/marcille.png --image-protocol kitty
            set -g last_git_root "$git_root"
          end
        else
          set -g last_git_root ""
        end
      end

      thefuck --alias | source
      zoxide init fish | source
    '';
  };
}
