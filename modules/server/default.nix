{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/jellyfin.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
