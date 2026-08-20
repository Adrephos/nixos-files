{ pkgs, inputs, ... }:
let
  brave-packages = inputs.brave-previews.packages.${pkgs.stdenv.hostPlatform.system};
  brave-beta = brave-packages.brave-beta;
  brave-nightly = brave-packages.brave-nightly;
in
{
  imports = [
    ./hyprland
    ./niri.nix
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
    brave-beta
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
      historySize = 200;
      imageDisplay = {
        type = "kitty";
        scaleX = 25;
        scaleY = 25;
        heightCut = 14;
      };
    };
    activitywatch = {
      enable = true;
      watchers = {
        awatcher = {
          package = pkgs.awatcher;
          executable = "awatcher";
        };
      };
    };
  };
}
