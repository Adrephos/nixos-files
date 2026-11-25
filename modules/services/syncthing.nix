{
  services.syncthing = {
    enable = true;
    user = "gleipnir";
    dataDir = "/home/gleipnir/.config/syncthing";
    configDir = "/home/gleipnir/.config/syncthing";
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "phone" = {
          id = "TCD5MAE-PBCM7VY-YOANEUL-CCQJBCG-2HUKBAI-JTXQING-F5H4COG-QY7IPQO";
        };
        "vin" = {
          id = "5WKJG42-5FM7AUW-CNV5WDX-ZTBTMP7-CBEJCRN-U6ZJO4Z-7FDHP3J-QL5TBA3";
        };
      };
      folders = {
        "Pictures" = {
          path = "/srv/media/Pictures";
          devices = [
            "phone"
            "vin"
          ];
        };
      };
    };
  };

  systemd.services.syncthing = {
    after = [ "srv-media.mount" ];
    requires = [ "srv-media.mount" ];
  };
}
