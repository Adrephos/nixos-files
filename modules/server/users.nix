{
  users.users.gleipnir = {
    isNormalUser = true;
    description = "gleipnir";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "media"
    ];
  };

  users.groups.media = { };
  users.users.jellyfin.extraGroups = [ "media" ];
  users.users.qbittorrent.extraGroups = [ "media" ];
}
