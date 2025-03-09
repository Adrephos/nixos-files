{ ... }: {
  imports = [
    ./grub.nix
    ./pipewire.nix
    ./locale.nix
    ./input.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  programs.nano.enable = false;
}
