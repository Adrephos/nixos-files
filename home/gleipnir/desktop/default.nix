{ pkgs, inputs, ... }:
let
  brave-packages = inputs.brave-previews.packages.${pkgs.stdenv.hostPlatform.system};
  brave-nightly = brave-packages.brave-nightly;
in
{
  imports = [
    ./niri.nix
    ./waybar.nix
    ./wlogout.nix
    ./theme.nix
    ./anki.nix
    ./default-apps.nix
  ];

  home.packages = with pkgs; [
    mpv
    teams-for-linux
    kdePackages.okular
    dunst
    libnotify
    inotify-tools
    networkmanagerapplet
    pear-desktop
    brave-nightly
    chromium
    playerctl
    pamixer
    noto-fonts-cjk-sans
    onedriver
    udiskie
    keepassxc
    xclip
    wl-clipboard
    xxd
    psmisc
    gnumake
    transmission_4-gtk
    godot
  ];

  xdg.desktopEntries = {
    obsidian = {
      categories = [ "Office" ];
      comment = "Knowledge base";
      exec = "fish -c obsidian %u";
      icon = "obsidian";
      mimeType = [ "x-scheme-handler/obsidian" ];
      name = "Obsidian";
      type = "Application";
    };
  };

  services = {
    clipse = {
      enable = true;
      settings = {
        historySize = 200;
        enableMouse = false;
        imageDisplay = {
          type = "kitty";
          scaleX = 25;
          scaleY = 25;
          heightCut = 14;
        };
      };
    };
  };
}
