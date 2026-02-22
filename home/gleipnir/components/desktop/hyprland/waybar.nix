# Adapted from https://github.com/gaurav23b/simple-hyprland/tree/main/configs/waybar
{ pkgs, ... }:

let
  colors = {
    base = "rgba(28, 28, 42, 20)"; # A shade between original base and surface1
    text = "#cdd6f4";
    subtext0 = "#a6adc8";
    subtext1 = "#b5e8e0";
    lavender = "#b7b7e3";
    surface0 = "#11111b"; # Catppuccin Mocha Crust (darker)
    surface1 = "#24243600"; # Custom darker shade of original surface1
    overlay0 = "#6c7086";
    red = "#eba0ac";
    green = "#a6e3a1";
    blue = "#89b4fa";
    yellow = "#f9e2af";
    peach = "#fab387";
    black = "#11111b";
    gray = "#555869";
    darkGreen = "#99ffdd";
    darkYellow = "#ffcc66";
  };
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        mode = "dock";
        exclusive = false;
        start_hidden = true;
        passthrough = false;
        "gtk-layer-shell" = true;
        height = 0;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "tray"
          "clock"
        ];

        "hyprland/window" = {
          format = "󱄅 {}";
          separate-outputs = true;
          max-length = 60;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          "all-outputs" = false;
          "on-click" = "activate";
          format = "{icon}";
          "format-icons" = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
        };

        tray = {
          "icon-size" = 13;
          spacing = 10;
        };

        clock = {
          format = "{:L%Y年%m月%d日 (%a) %H:%M}";
          interval = 1;
          rotate = 0;
          "tooltip-format" = "<tt>{calendar}</tt>";
          locale = "ja_JP.UTF-8";
        };
      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: JetBrainsMono Nerd Font, monospace;
          font-weight: bold;
          font-size: 12px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: ${colors.text};
      }

      #workspaces button {
          padding: 4px;
          color: ${colors.gray};
          margin-right: 4px;
          font-size: 10px;
      }

      #workspaces button.active {
          color: ${colors.subtext0};
      }

      #workspaces button.focused {
          color: ${colors.subtext0};
          background: ${colors.red};
          border-radius: 10px;
      }

      #workspaces button.urgent {
          color: ${colors.black};
          background: ${colors.green};
          border-radius: 10px;
      }

      #workspaces button:hover {
          background: ${colors.text};
          color: ${colors.black};
          border-radius: 10px;
      }

      #window,
      #clock,
      #workspaces,
      #tray {
          background: ${colors.surface0};
          padding: 0px 8px;
          margin: 2px 0px;
          margin-top: 2px;
          /* border: 1px solid ${colors.surface1}; */
      }

      #tray {
          border-radius: 10px;
          margin-right: 10px;
          background: ${colors.surface1};
      }

      #workspaces {
          background: ${colors.surface1};
          border-radius: 10px;
          margin-left: 10px;
          padding-right: 0px;
          padding-left: 5px;
      }

      #window {
          border-radius: 10px;
          margin-left: 60px;
          margin-right: 60px;
          background: ${colors.surface1};
      }

      #clock {
          color: ${colors.subtext0};
          border-radius: 10px 10px 10px 10px;
          margin-right: 5px;
          border-left: 0px;
          background: ${colors.surface1};
      }
    '';
  };

  home.packages = with pkgs; [
    playerctl
    jq
  ];
}
