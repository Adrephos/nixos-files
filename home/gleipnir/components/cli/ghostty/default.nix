{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableFishIntegration = true;
    settings = {
      command = "fish";
      working-directory = "home";
      window-inherit-working-directory = false;
      gtk-titlebar = false;
      font-family = "JetBrainsMono NF";
      font-size = 15;
      theme = "catppuccin-mocha";
      background-opacity = 0.9;
      background = "#101119";
      cursor-text = "#000000";
      window-padding-x = 10;
      window-padding-y = 10;
      gtk-wide-tabs = false;
      gtk-adwaita = true;
      gtk-single-instance = true;
    };
  };
}
