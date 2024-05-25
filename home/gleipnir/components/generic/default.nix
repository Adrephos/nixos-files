{ lib, config, pkgs, ... }: {
  imports = [
    ../cli
  ];

  fonts.fontconfig.enable = true;

  qt.enable = true;
  qt.platformTheme.name = "qtct";
  qt.style.name = "kvantum";

  home = {
    username = lib.mkDefault "gleipnir";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      (catppuccin-kvantum.override {
        accent = "Mauve";
        variant = "Mocha";
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
      theme = "Catppuccin-Macchiato";
      settings = {
        shell = "fish";
        single_window_padding_width = 10;
        background_opacity = "0.9";
      };
      font = {
        name = "JetBrainsMono NFM";
        size = 12;
      };
      shellIntegration.enableFishIntegration = true;
    };
  };
}
