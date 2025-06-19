{ lib, config, pkgs, inputs, ... }:
let
  variant = "mocha";
  accent = "mauve";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "86d28e4fb4f25f36cc501b8cb0badb37a6b14263";
    hash = "sha256-m/gJTDm0cVkIdcQ1ZJliPqBhNKoCW1FciLkuq7D1mxo=";
  };
  relative-motions-plugin = pkgs.fetchFromGitHub {
    owner = "dedukun";
    repo = "relative-motions.yazi";
    rev = "2e3b6172e6226e0db96aea12d09dea2d2e443fea";
    hash = "sha256-v0e06ieBKNmt9DATdL7R4AyVFa9DlNBwpfME3LHozLA=";
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

  services = {
    easyeffects.enable = true;
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

    yazi = {
      enable = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      enableFishIntegration = true;
      settings = {
        mgr = {
          show_hidden = true;
          sort_by = "mtime";
          sort_dir_first = true;
          sort_reverse = true;
        };
      };
      keymap = {
        mgr.prepend_keymap = [
          { run = "plugin mount"; on = [ "M" ]; }
          { run = "plugin relative-motions"; on = [ "m" ]; }
          { run = "plugin zoom 1"; on = [ "+" ]; }
          { run = "plugin zoom -1"; on = [ "-" ]; }
        ];
      };
      plugins = {
        mount = pkgs.yaziPlugins.mount;
        zoom = "${yazi-plugins}/zoom.yazi";
        git = "${yazi-plugins}/git.yazi";
        chmod = "${yazi-plugins}/chmod.yazi";
        glow = "${yazi-plugins}/glow.yazi";
        full-border = "${yazi-plugins}/full-border.yazi";
        relative-motions = relative-motions-plugin;
      };
      initLua = ./init.lua;
    };

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
