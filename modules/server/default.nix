{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
    ../services/jellyfin.nix
    ../services/transmission.nix
    ../services/samba.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
