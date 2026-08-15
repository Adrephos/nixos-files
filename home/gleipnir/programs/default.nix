{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./fish.nix
    ./yazi.nix
    ./starship.nix
    ./tmux.nix
    ./kitty.nix
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    };
  };
}
