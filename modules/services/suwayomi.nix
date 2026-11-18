{ config, pkgs, ... }:
{
  services.suwayomi-server = {
    enable = true;
    package = pkgs.suwayomi-server.overrideAttrs (old: rec {
      version = "2.4.2366";
      src = pkgs.fetchurl {
        url = "https://github.com/Suwayomi/Suwayomi-Server/releases/download/v${version}/Suwayomi-Server-v${version}.jar";
        hash = "sha256-r5/rIK+dfr6eMHaebG68f8erHERziNQuAoCx2l/ge/0=";
      };
    });
    group = "media";
    settings.server = {
      ip = "127.0.0.1";
      port = 4567;
      downloadAsCbz = true;
      downloadsPath = "/srv/media3/Manga/downloads";
      localSourcePath = "/srv/media3/Manga/local";

      basicAuthEnabled = true;
      basicAuthUsername = "gleipnir";
      # Put the password alone in this file, readable by root only.
      basicAuthPasswordFile = "/etc/nixos-secrets/suwayomi";

      flareSolverrEnabled = true;
      flareSolverrUrl = "http://127.0.0.1:${toString config.services.flaresolverr.port}";
    };
  };

  services.flaresolverr.enable = true;

  systemd.services.suwayomi-server = {
    unitConfig.RequiresMountsFor = "/srv/media3";
    serviceConfig.UMask = "0002";
  };

  systemd.tmpfiles.rules = [
    "d /srv/media3/Manga 2775 suwayomi media - -"
    "d /srv/media3/Manga/downloads 2775 suwayomi media - -"
    "d /srv/media3/Manga/local 2775 suwayomi media - -"
  ];
}
