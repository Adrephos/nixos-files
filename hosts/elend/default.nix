{
  imports = [
    ./hardware-configuration.nix
    ../../modules/server
  ];

  networking.hostName = "elend";

  networking.networkmanager.ensureProfiles.profiles."eno1-static" = {
    connection = {
      id = "eno1-static";
      type = "ethernet";
      interface-name = "eno1";
      autoconnect = "true";
      autoconnect-priority = "10";
    };
    ipv4 = {
      method = "manual";
      addresses = "192.168.58.114/24";
      gateway = "192.168.58.1";
      dns = "192.168.58.1";
    };
  };

  # Existing general-purpose HDD, labeled "IDK" (Pictures, github.com backups, Video/Anime, Video/College).
  fileSystems."/srv/media" = {
    device = "/dev/disk/by-label/IDK";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  system.stateVersion = "23.11";
}
