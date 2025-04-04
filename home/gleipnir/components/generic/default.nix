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
    platformTheme.name = "gtk";
    style.name = "gtk2";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Catppuccin-Mocha-Mauve-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    iconTheme = {
      name = "Catpuccin-papirus";
      package = (pkgs.catppuccin-papirus-folders.override {
        accent = "${accent}";
        flavor = "${variant}";
      });
    };
    theme = {
      name = "Catppuccin-GTK";
      package = (pkgs.catppuccin-gtk.override {
        accents = [ "${accent}" ];
        variant = "${variant}";
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

    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      extraConfig = "background #101119";
      settings = {
        shell = "fish";
        single_window_padding_width = 10;
        background_opacity = "0.96";
      };
      font = {
        name = "JetBrainsMono NF";
        size = 12;
      };
      keybindings = {
        "kitty_mod+y" = "new_tab_with_cwd";
      };
      shellIntegration.enableFishIntegration = true;
    };
    mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            mpvacious
          ];

          mpv = pkgs.mpv-unwrapped;
        }
      );
    };
  };
}
