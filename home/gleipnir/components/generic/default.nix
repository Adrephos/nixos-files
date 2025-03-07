{ lib, config, pkgs, ... }: {
  imports = [
    ../cli
  ];

  fonts.fontconfig.enable = true;

  qt.enable = true;
  qt.platformTheme.name = "qtct";
  qt.style.name = "kvantum";

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Catppuccin-Mocha-Mauve-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    iconTheme = {
      name = "papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Catppuccin-GTK";
      package = (pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      });
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
        accent = "mauve";
        variant = "mocha";
      })
    ];
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Mauve";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
    git.enable = true;

    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      settings = {
        shell = "fish";
        single_window_padding_width = 10;
        background_opacity = "0.9";
      };
      font = {
        name = "JetBrainsMono NF";
        size = 12;
      };
      shellIntegration.enableFishIntegration = true;
    };
  };
}
