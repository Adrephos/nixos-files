{ ... }: {
  imports = [
    ./grub.nix
    ./pipewire.nix
    ./locale.nix
    ./input.nix
  ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = "auto";
    cores = 0;
  };

  nixpkgs.config.allowUnfree = true;
  programs.nano.enable = false;
}
