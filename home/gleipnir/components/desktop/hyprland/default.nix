{ config, pkgs, ... }:
{
  imports = [
    ./binds.nix
    ./visual.nix
    ./waybar.nix
    ./hyprlock.nix
    ./wlogout.nix
    ./windowrules.nix
  ];

  home = {
    packages = with pkgs; [
      grim
      slurp
      hyprshot
      hyprsunset
      wl-clipboard
      hyprsunset
      swww
      rofi
    ];
    sessionVariables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      ENABLE_VKBASALT = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
      HYPRSHOT_DIR = "/home/${config.home.username}/Pictures/Screenshots";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = [
        # "HDMI-A-1,1920x1080@144,0x0,1,cm,auto"
        # "eDP-1,1920x1080@144,1920x0,1,cm,auto"
        "eDP-1,1920x1080@144,0x0,1,cm,auto"
        "HDMI-A-1,1920x1080@144,1920x0,1,cm,auto"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        left_handed = false;
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = -0.2;
        resolve_binds_by_sym = 1;
      };

      misc = {
        middle_click_paste = false;
      };

      workspace = [
        "special:terminal, border:false, on-created-empty:$terminal"
        "special:music,  on-created-empty:$music"
      ];

      exec-once = [
        "sh -c 'sleep 5; hyprctl reload; hyprsunset &'"
        "sh -c 'swww-daemon --format xrgb & disown'"
        "sh -c 'wper &'"

        "sh -c 'xrandr --output HDMI-A-1 --primary &'"

        "sh -c 'sleep 10; wper &'"
        "sh -c 'waybar &'"
        "sh -c 'udiskie &'"
        "sh -c 'awatcher &'"
        "sh -c 'clipse -listen &'"

        "sh -c 'fcitx5 -d --replace &'"
        "sh -c 'nm-applet &'"
        "sh -c 'blueman-applet &'"

        "sh -c 'sleep 10; check-ram &'"
        "sh -c 'sleep 10; scrcpy-prompt &'"
        "sh -c 'sleep 10; start-gpu-recording &'"
        "sh -c 'sleep 5; profile &'"
        "sh -c 'sleep 10; temperature &'"
        "sh -c 'sleep 10; monitor-change &'"

        "sh -c 'dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE &'"
        "sh -c 'sleep 10; rclone cmount gdrive:/ ~/drive/gdrive/ &'"
        "sh -c 'sleep 20; hyprctl dispatch exec [workspace 10 silent] \"keepassxc\" &'"

        "[workspace 1 silent] discord"
        "[workspace special:music silent] $music"
      ];

      env = [
        # Nvidia
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        # "ELECTRON_OZONE_PLATFORM_HINT,auto"

        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      "$terminal" = "kitty";
      "$filemanager" = "kitty -e fish -c yazi";
      "$resourcemonitor" = ''kitty --class="com.adrephos.floating" -e btop'';
      "$menu" = "rofi -show drun -icon-theme Papirus -show-icons";
      "$sshot_region" = ''grim -g "$(slurp -d)" - | wl-copy -t image/png'';
      "$sshot_monitor" = "hyprshot -m output --freeze";
      "$music" = "pear-desktop";
      "$switchkbd" = "switch_kbd_locale";
      "$session" = "kitty session";
      "$toggle_bar" = "pkill -SIGUSR1 waybar";
      "$stop_replay" = "save-gpu-recording";
      "$clipboard" = ''kitty --class="com.adrephos.floating" -e clipse'';
      # "$show_time" = ''notify-send "$(date '+%B %d %Y')" "$(date '+%A, %H:%M')" -a "Date & Time"'';
      "$show_time" =
        ''notify-send "$(LC_TIME=ja_JP.UTF-8 date '+%Y年%m月%d日 (%a)')" "$(LC_TIME=ja_JP.UTF-8 date '+%H時%M分')" -a "日付と時刻"'';
    };
  };
}
