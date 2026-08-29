{
  imports = [
    ./hardware-configuration.nix
    ../../modules/server
  ];

  networking.hostName = "elend";
  system.stateVersion = "23.11";
}
