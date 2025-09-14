{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    shell = "${pkgs.fish}/bin/fish";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_theme night
          set -g @tokyo-night-tmux_transparent 1

          set -g @tokyo-night-tmux_window_id_style none
          set -g @tokyo-night-tmux_show_wbg 0
          set -g @tokyo-night-tmux_show_music 1
          set -g @tokyo-night-tmux_show_git 0
        '';
      }
    ];

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      # set -g default-terminal "xterm-256color"
      # set -ga terminal-overrides ",*256col*:Tc"
      # set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

      set -g default-terminal 'tmux-256color'
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set -g allow-passthrough on
      set-environment -g COLORTERM "truecolor"

      # Update tmux statusline every second
      set -g status-interval 1

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
