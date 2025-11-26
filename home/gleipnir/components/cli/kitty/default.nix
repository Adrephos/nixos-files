{ ... }: {
  programs.kitty = {
    enable = true;
    themeFile = "rose-pine-moon";
    settings = {
      shell = "fish";
      single_window_padding_width = 0;
      background_opacity = "0.85";
      # tab_bar_edge = "top";
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
      name = "JetBrainsMono NF Light";
      size = 13;
    };
    shellIntegration.enableFishIntegration = true;
  };
}
