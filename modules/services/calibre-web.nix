{
  services.calibre-web = {
    enable = true;
    openFirewall = true;
    group = "media";
    listen = {
      ip = "0.0.0.0";
      port = 8083;
    };
    options = {
      enableKepubify = true;
      enableBookUploading = true;
    };
  };

  systemd.services.calibre-web.serviceConfig.SupplementaryGroups = [ "media" ];
}
