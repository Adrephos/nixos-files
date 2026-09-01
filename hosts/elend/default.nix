{
  imports = [
    ./hardware-configuration.nix
    ../../modules/server
  ];

  networking.hostName = "elend";

  # Existing general-purpose HDD, labeled "IDK" (Pictures, github.com backups, Video/Anime, Video/College).
  fileSystems."/srv/media" = {
    device = "/dev/disk/by-label/IDK";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  system.stateVersion = "23.11";
}
