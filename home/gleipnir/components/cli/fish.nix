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
    plugins = [
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
          sha256 = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
      }
    ];
    interactiveShellInit = ''
      set -U fish_greeting
      fish_config theme choose Catppuccin\ Macchiato
      fish_config prompt choose astronaut

      set kitty_count (pgrep -c "kitty")

      if test $kitty_count -eq 1 && [ -z "$ZELLIJ" ]
        neofetch --kitty /home/${config.home.username}/Pictures/onefetch/asuka.png --size 375px
      end

      function cd
        z $argv
        set git_root (git rev-parse --show-toplevel 2>/dev/null)
        set revaisor_dir "/home/${config.home.username}/workspace/github.com/revaisor"

        if test -n "$git_root"
          if string match -r "^"$revaisor_dir"(/.*|\$)" $PWD
            if not ssh-add -l | grep -q "revaisor"
              ssh-add -D
              ssh-add ~/secrets/ssh/revaisorkey
            end
            git config user.email "juanesteban@revaisor.com"
          else if not ssh-add -l | grep -q "adrephos"
            ssh-add ~/secrets/ssh/id_ed25519
          end
          if test "$git_root" != "$last_git_root" && [ -z "$ZELLIJ" ]
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
