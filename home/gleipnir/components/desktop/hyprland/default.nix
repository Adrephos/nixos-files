{ config, pkgs, ... }:
{
  imports = [
    ./binds.nix
    ./visual.nix
    ./waybar.nix
    ./hyprlock.nix
    ./wlogout.nix
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
        "special:terminal, on-created-empty:$terminal"
        "special:music,  on-created-empty:$music"
        "special:magic, on-created-empty:anki"
      ];

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "float, class:^(com.adrephos.floating)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "float, title:.*Checker.Plus.for.Google.Calendar.*"
        "float, title:Extension.*"
        "size 1200 700, class:^(com.adrephos.floating)$"
        "tile, class:^(.scrcpy-wrapped)$"
        "idleinhibit fullscreen, class:^(Boosteroid)$"
        "noanim, class:^(ueberzugpp).*$"
      ];

      exec-once = [
        "sleep 5 && hyprctl reload && hyprsunset"
        ''swww-daemon --format xrgb && swww img "$(find ~/Pictures/Wallpaper/Current/ -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)"''
        "xrandr --output HDMI-A-1 --primary"
        "wper"
        "waybar"
        "udiskie"
        "awatcher"
        "clipse -listen"

        "fcitx5 -d --replace"
        "nm-applet"
        "blueman-applet"

        "sleep 12 && ~/bin/check_ram"
        "sleep 12 && ~/bin/scrcpy_promt"
        "sleep 12 && ~/bin/start-gpu-recording"
        "sleep 5 && ~/bin/profile"
        "hyprsunset"
        "sleep 6 && ~/bin/temperature"

        "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE"
        "sleep 10 && systemctl --user start onedriver@home-gleipnir-onedrive-college.service"

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

      # "$terminal" = "kitty";
      "$terminal" = "kitty";
      "$filemanager" = ''kitty -e fish -c yazi'';
      "$resourcemonitor" = ''kitty --class="com.adrephos.floating" -e btop'';
      "$menu" = "rofi -show drun -icon-theme Papirus -show-icons";
      "$sshot_region" = "sleep 0.3 && hyprshot -m region --clipboard-only --freeze";
      "$sshot_monitor" = "hyprshot -m output --freeze";
      "$music" = "youtube-music";
      # "$music" = "tidal-hifi";
      "$switchkbd" = "switch_kbd_locale";
      "$session" = "kitty session";
      "$toggle_bar" = "pkill -SIGUSR1 waybar";
      "$stop_replay" = "save-gpu-recording";
      "$clipboard" = ''kitty --class="com.adrephos.floating" -e clipse'';
    };
  };
}
