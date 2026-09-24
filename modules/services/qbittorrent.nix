{
  services.qbittorrent = {
    enable = true;
    webuiPort = 8080;
    torrentingPort = 6881;
    openFirewall = true;
  };

  systemd.services.qbittorrent.serviceConfig = {
    SupplementaryGroups = [ "media" ];
    UMask = "0002";
  };
}
