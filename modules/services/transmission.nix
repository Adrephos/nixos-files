{ pkgs, ... }:
{
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    openFirewall = true;
    openPeerPorts = true;
    openRPCPort = true;
    settings = {
      download-dir = "/srv/media/Video";
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = true;
      rpc-whitelist = "127.0.0.1,192.168.58.*";
      peer-port = 51413;
      peer-port-random-on-start = false;
    };
  };

  users.users.transmission.extraGroups = [ "users" ];

  systemd.tmpfiles.rules = [ 
    "z /srv/media/Video/Anime 0775 gleipnir users -"
    "z /srv/media/Video/Movies 0775 gleipnir users -"
  ];

  systemd.services.transmission = {
    after = [ "srv-media.mount" ];
    requires = [ "srv-media.mount" ];
  };

  systemd.services.systemd-tmpfiles-setup = {
    after = [ "srv-media.mount" ];
    requires = [ "srv-media.mount" ];
  };
}
