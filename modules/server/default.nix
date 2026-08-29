{
  imports = [
    ../shared
    ./packages.nix
    ./users.nix
    ../services/docker.nix
    ../services/openssh.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
