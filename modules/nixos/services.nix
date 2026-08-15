{ pkgs, ... }:
{
  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    pipewire.extraConfig.pipewire."99-crackling" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
      };
    };
    pulseaudio.enable = false;

    postgresql = {
      enable = true;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database DBuser auth-method
        local all      all    trust
        host  all all 127.0.0.1/32 trust
        host  all all ::1/128      trust
      '';
    };

    udisks2.enable = true;
    blueman.enable = true;
    power-profiles-daemon.enable = true;
    asusd.enable = true;
  };

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
}
