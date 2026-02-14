# Adapted from https://github.com/gaurav23b/simple-hyprland/tree/main/configs/waybar
{ pkgs, ... }:

let
  colors = {
    base = "rgba(28, 28, 42, 1)"; # A shade between original base and surface1
    text = "#cdd6f4";
    subtext0 = "#a6adc8";
    subtext1 = "#b5e8e0";
    lavender = "#b7b7e3";
    surface0 = "#11111b"; # Catppuccin Mocha Crust (darker)
    surface1 = "#242436"; # Custom darker shade of original surface1
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
        mode = "hide";
        start_hidden = true;
        exclusive = false;
        passthrough = false;
        "gtk-layer-shell" = true;
        height = 0;
        modules-left = [
          "clock"
          "hyprland/workspaces"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "tray"
          "memory"
          "cpu"
          "network"
          "battery"
          "backlight"
          "pulseaudio"
          "pulseaudio#microphone"
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
          format = "{:%A    %B-%d    %H:%M}";
          interval = 1;
          rotate = 0;
          "tooltip-format" = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              months = "<span color='${colors.subtext0}'><b>{}</b></span>";
              weekdays = "<span color='${colors.subtext0}'><b>{}</b></span>";
              today = "<span color='${colors.green}'><b>{}</b></span>";
              days = "<span color='${colors.gray}'><b>{}</b></span>";
            };
          };
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          "format-icons" = [ "󰃞" "󰃟" "󰃠" ];
          "on-scroll-up" = "brightnessctl set 1%+";
          "on-scroll-down" = "brightnessctl set 1%-";
          "min-length" = 6;
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{time} {icon}";
          "format-icons" = [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          tooltip = false;
          "format-muted" = "  Muted";
          "on-click" = "pamixer -t";
          "on-scroll-up" = "pamixer -i 1";
          "on-scroll-down" = "pamixer -d 1";
          "scroll-step" = 5;
          "format-icons" = {
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" "" ];
          };
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "  Muted";
          "on-click" = "pamixer --default-source -t";
          "on-scroll-up" = "pamixer --default-source -i 5";
          "on-scroll-down" = "pamixer --default-source -d 5";
          "scroll-step" = 5;
        };

        memory = {
          states = {
            c = 90;
            h = 60;
            m = 30;
          };
          interval = 10;
          format = "  {percentage}%";
          "format-m" = "  {percentage}%";
          "format-h" = "  {percentage}%";
          "format-c" = "  {percentage}%";
          "format-alt" = "  {percentage}%";
          "max-length" = 10;
          tooltip = true;
          "tooltip-format" = "  {used:0.1f}GB/{total:0.1f}GB ({percentage}%)";
        };

        cpu = {
          interval = 10;
          format = "󰍛 {usage}%";
          "format-alt" = "{icon0}{icon1}{icon2}{icon3}";
          "format-icons" = [ " " "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        };

        network = {
          tooltip = true;
          "format-wifi" = "  {essid}";
          "format-ethernet" = "󰈀 ";
          "tooltip-format" = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
          "format-linked" = "󰈀 {ifname} (No IP)";
          "format-disconnected" = "󰖪 ";
          "tooltip-format-disconnected" = "Disconnected";
          "format-alt" = "<span foreground='${colors.darkGreen}'> {bandwidthDownBytes}</span> <span foreground='${colors.darkYellow}'> {bandwidthUpBytes}</span>";
          interval = 2;
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
          background: ${colors.base};
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
      #battery,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #workspaces,
      #tray,
      #backlight {
          background: ${colors.surface0};
          padding: 0px 8px;
          margin: 2px 0px;
          margin-top: 2px;
          /* border: 1px solid ${colors.surface1}; */
      }

      #backlight {
          border-radius: 10px 0px 0px 10px;
          background: ${colors.surface1};
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

      #cpu {
          border-radius: 0px 10px 10px 0px;
          margin-right: 10px;
          background: ${colors.surface1};
      }

      #memory {
          border-radius: 10px 0px 0px 10px;
          background: ${colors.surface1};
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
          margin-left: 5px;
          border-right: 0px;
          background: ${colors.surface1};
      }

      #network {
          color: ${colors.subtext0};
          border-radius: 10px 0px 0px 10px;
          background: ${colors.surface1};
      }

      #pulseaudio {
          color: ${colors.subtext0};
          border-left: 0px;
          border-right: 0px;
          background: ${colors.surface1};
      }

      #pulseaudio.microphone {
          color: ${colors.subtext0};
          border-radius: 0px 10px 10px 0px;
          border-left: 0px;
          border-right: 0px;
          margin-right: 5px;
          background: ${colors.surface1};
      }

      #battery {
          color:${colors.subtext0};
          border-radius: 0px 10px 10px 0px;
          margin-right: 10px;
          background: ${colors.surface1};
      }
    '';
  };

  home.packages = with pkgs; [
    playerctl
    jq
  ];
}
