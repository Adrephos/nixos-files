{ pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "ja_JP.UTF-8/UTF-8" ];

    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-hangul
        fcitx5-gtk
        libsForQt5.fcitx5-qt
        kdePackages.fcitx5-qt
      ];
    };
  };

  environment.sessionVariables = {
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    max-jobs = "auto";
    cores = 0;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    nano.enable = false;
    nix-ld.enable = true;
  };

  time.timeZone = "America/Bogota";
}
