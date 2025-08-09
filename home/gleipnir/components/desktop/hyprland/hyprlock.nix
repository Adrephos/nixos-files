# From https://github.com/gaurav23b/simple-hyprland/blob/main/configs/hypr/hyprlock.conf
{ config, ... }:
{
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "hyprlock";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          inhibit_sleep = 1;
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "hyprlock";
          }
          {
            timeout = 3600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
        };

        background = [
          {
            monitor = "";
            path = "/home/${config.home.username}/Pictures/Wallpaper/Other/ranni-cropped.jpg";
            blur_passes = 2;
            blur_size = 4;
            brightness = 0.8;
            contrast = 0.8;
            color = "rgba(17, 17, 17, 1.0)";
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -20";
            monitor = "";
            outline_thickness = 3;
            dots_size = 0.33;
            dots_spacing = 0.15;
            dots_center = true;
            dots_rounding = -1;
            outer_color = "rgb(a6adc8)";
            inner_color = "rgb(11111b)";
            font_color = "rgb(a6adc8)";
            fade_on_empty = true;
            fade_timeout = 1000;
            placeholder_text = "<i>Input Password...</i>";
            hide_input = false;
            rounding = -1;
            check_color = "rgb(204, 136, 34)";
            fail_color = "rgb(204, 34, 34)";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            fail_transition = 100;
            capslock_color = -1;
            numlock_color = -1;
            bothlock_color = -1;
            invert_numlock = false;
            swap_font_color = false;
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$TIME\"";
            font_size = 55;
            font_family = "Fira Semibold";
            position = "-100, 40";
            halign = "right";
            valign = "bottom";
            color = "rgba(a6adc8)";
            shadow_passes = 5;
            shadow_size = 10;
          }
          {
            monitor = "";
            text = ''Accept the pain, but don't accept that you deserved it.'';
            font_size = 20;
            font_family = "Fira Semibold";
            position = "-100, 160";
            halign = "right";
            valign = "bottom";
            color = "rgba(a6adc8)";
            shadow_passes = 5;
            shadow_size = 10;
          }
        ];

        image = [
          {
            monitor = "";
            path = "/home/${config.home.username}/Pictures/pfp/614099fed01eb9a0579ab80ebbf83149-cropped.jpg";
            size = 280;
            rounding = -1;
            border_size = 4;
            border_color = "rgb(a6adc8)";
            rotate = 0;
            reload_time = -1;
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
