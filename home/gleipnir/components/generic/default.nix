{ lib, config, pkgs, ... }:
let
  variant = "mocha";
  accent = "mauve";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };

in
{
  imports = [
    ../cli
  ];

  fonts.fontconfig.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = (pkgs.catppuccin-papirus-folders.override {
        accent = "${accent}";
        flavor = "${variant}";
      });
    };
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = (pkgs.catppuccin-gtk.override {
        accents = [ "${accent}" ];
        variant = "${variant}";
      });
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  home = {
    username = lib.mkDefault "gleipnir";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      (catppuccin-kvantum.override {
        accent = "${accent}";
        variant = "${variant}";
      })
    ];
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    # The important bit is here, links the theme directory from the package to a directory under `~/.config`
    # where Kvantum should find it.
    "Kvantum/catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
    git.enable = true;

    neovim = {
      enable = true;
      extraLuaPackages = ps: [ ps.magick ];
      extraPackages = [ pkgs.imagemagick ];
    };

    # ghostty = {
    #   enable = true;
    #   package = pkgs.ghostty;
    #   enableFishIntegration = true;
    #   settings = {
    #     command = "fish";
    #     gtk-titlebar = false;
    #     font-family = "JetBrainsMono NF";
    #     font-size = 15;
    #     theme = "catppuccin-mocha";
    #     background-opacity = 0.9;
    #     background = "#101119";
    #     cursor-text = "#000000";
    #     window-padding-x = 10;
    #     window-padding-y = 10;
    #     font-style = "Medium";
    #     gtk-wide-tabs = false;
    #     gtk-adwaita = true;
    #     gtk-single-instance = true;
    #   };
    # };

    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      settings = {
        shell = "fish";
        single_window_padding_width = 10;
        background_opacity = "0.9";
        tab_bar_edge = "top";
        background = "#101119";
      };
      keybindings = {
        "alt+1" = "goto_tab 1";
        "alt+2" = "goto_tab 2";
        "alt+3" = "goto_tab 3";
        "alt+4" = "goto_tab 4";
        "alt+5" = "goto_tab 5";
        "alt+6" = "goto_tab 6";
        "alt+7" = "goto_tab 7";
        "alt+8" = "goto_tab 8";
        "alt+9" = "goto_tab 9";
      };
      font = {
        name = "JetBrainsMono NF";
        size = 15;
      };
      shellIntegration.enableFishIntegration = true;
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    };

    tmux = {
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
          plugin = tmuxPlugins.catppuccin;
          extraConfig = '' 
            set -g @catppuccin_flavour 'mocha'
            set -g @catppuccin_window_tabs_enabled on
            set -g @catppuccin_date_time "%H:%M"
          '';
        }
      ];

      extraConfig = ''
        # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set -g allow-passthrough on
        set-environment -g COLORTERM "truecolor"

        # Mouse works as expected
        set-option -g mouse on
        # easy-to-remember split pane commands
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
    };

    # mpv = {
    #   enable = true;

    #   package = (
    #     pkgs.mpv-unwrapped.wrapper {
    #       scripts = with pkgs.mpvScripts; [
    #         mpvacious
    #       ];

    #       mpv = pkgs.mpv-unwrapped;
    #     }
    #   );
    # };
  };
}
