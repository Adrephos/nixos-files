{
  lib,
  config,
  pkgs,
  ...
}:
let
  variant = "mocha";
  accent = "mauve";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override { inherit variant accent; };
in
{
  fonts.fontconfig.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      "org/gnome/nautilus/preferences" = {
        default-sort-order = "mtime";
        default-sort-in-reverse-order = true;
        search-view-default-sort-order = "mtime";
      };

      "org/gtk/settings/file-chooser" = {
        sort-directories-first = true;
      };
    };
  };

  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    iconTheme = {
      name = "Papirus-Dark";
      package = (
        pkgs.catppuccin-papirus-folders.override {
          accent = "${accent}";
          flavor = "${variant}";
        }
      );
    };
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = (
        pkgs.catppuccin-gtk.override {
          accents = [ "${accent}" ];
          variant = "${variant}";
        }
      );
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 16;
  };

  home.packages = with pkgs; [
    (catppuccin-kvantum.override {
      accent = "${accent}";
      variant = "${variant}";
    })
  ];

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    # The important bit is here, links the theme directory from the package to a directory under `~/.config`
    # where Kvantum should find it.
    "Kvantum/catppuccin-${variant}-${accent}".source =
      "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";
  };
}
