{ ... }: {
  imports = [
    ./grub.nix
    ./pipewire.nix
    ./locale.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  programs.nano.enable = false;
}
