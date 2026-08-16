{ pkgs, ... }:
let
  mkScript =
    name:
    pkgs.writeShellScriptBin name (builtins.readFile ../../scripts/${name});

  scriptNames = [
    "change-remote"
    "check-ram"
    "clip-dl"
    "cliphist-rofi"
    "copy-img"
    "fans"
    "fcitx5-toggle"
    "hytale"
    "mirror-hdmi"
    "monitor-change"
    "music-info"
    "note"
    "phone-screen"
    "pomodoro"
    "profile"
    "pux"
    "save-gpu-recording"
    "scrcpy-prompt"
    "start-gpu-recording"
    "start-manga-ocr"
    "temperature"
    "toggle-bluetooth"
    "volume-control"
    "watch-clip"
    "wper"
    "yomigrep-ocr"
  ];

  # toggle-mic needs the notification sounds' store path baked in, so it can't
  # go through the plain readFile helper like the others.
  micNotifyDir = ../../scripts/assets/mic-notify;
  toggle-mic = pkgs.writeShellScriptBin "toggle-mic" (
    builtins.replaceStrings [ "@MIC_NOTIFY_DIR@" ] [ "${micNotifyDir}" ] (
      builtins.readFile ../../scripts/toggle-mic
    )
  );

  scripts = (map mkScript scriptNames) ++ [ toggle-mic ];

  scriptDependencies = with pkgs; [
    android-tools
    awww
    cliphist
    coreutils
    curl
    fcitx5
    file
    findutils
    gawk
    gnugrep
    gpu-screen-recorder
    hyprland
    hyprshot
    imagemagick
    inotify-tools
    kdePackages.kdeconnect-kde
    libnotify
    lm_sensors
    lolcat
    neovim
    niri
    pipewire
    playerctl
    power-profiles-daemon
    procps
    python3
    rofi
    scrcpy
    timer
    tmux
    waybar
    wireplumber
    wl-clipboard
    wl-mirror
    xclip
    xrandr
    xsel
    zoxide
  ];
in
{
  environment = {
    homeBinInPath = true;
    systemPackages = scripts ++ scriptDependencies;
  };
}
