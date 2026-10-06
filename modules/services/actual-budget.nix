{ inputs, pkgs, ... }:
{
  imports = [ inputs.arion.nixosModules.arion ];

  virtualisation.arion.backend = "docker";

  # arion's own test suite fails on current nixpkgs (uses the now-removed
  # services.journald.console option in one of its test fixtures);
  # doesn't affect the actual arion binary we run.
  virtualisation.arion.package = (import inputs.arion { inherit pkgs; }).arion.overrideAttrs (old: {
    doCheck = false;
  });

  virtualisation.arion.projects.actual-budget.settings = {
    project.name = "actual-budget";
    services.actual.service = {
      image = "docker.io/actualbudget/actual-server:latest";
      ports = [ "5006:5006" ];
      volumes = [
        "/var/lib/actual-budget:/data"
      ];
      restart = "unless-stopped";
    };
  };

  networking.firewall.allowedTCPPorts = [ 5006 ];
}
