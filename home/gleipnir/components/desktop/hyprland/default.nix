{ pkgs, ... }:
{
  imports = [
    ./binds.nix
    ./visual.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swww
    rofi-wayland
  ];

  programs.wlogout = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "HDMI-A-1,1920x1080@144,0x0,1"
        "eDP-1,1920x1080@144,1920x0,1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        left_handed = true;
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = 0;
      };

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];

      exec = [
        ''swww-daemon --format xrgb && swww img "$(find ~/Pictures/Wallpaper/Current/ -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)"''
        "waybar"
        "udiskie"

        "fcitx5-remote -r"
        "fcitx5 -d --replace"
        "fcitx5-remote -r"
        "nm-applet"
        "sleep 10 && pkill -SIGUSR1 waybar"

        "sleep 12 && ~/bin/temperature"
        "sleep 12 && ~/bin/check_ram"
        "sleep 12 && ~/bin/scrcpy_promt"
        "sleep 12 && ~/bin/start-gpu-recording"
        "sleep 5 && ~/bin/profile"

        "discord"
        "greenclip daemon"

        "sleep 10 && systemctl --user start onedriver@home-gleipnir-onedrive-college.service"
      ];

      "$terminal" = "kitty";
      "$menu" = "rofi -show drun -icon-theme Papirus -show-icons";
      "$sshot" = ''grim -g "$(slurp -d)" - | wl-copy -t image/png'';
      "$music" = "youtube-music";
      "$switchkbd" = "switch_kbd_locale";
      "$session" = "kitty session";
      "$toggle_bar" = "pkill -SIGUSR1 waybar";
      "$stop_replay" = "save-gpu-recording";
      "$clipboard" = "rofi -modi 'clipboard:greenclip print' -show";
    };
  };
}
