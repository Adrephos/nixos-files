{ inputs, pkgs, ... }:
let
  selfSignedCert =
    pkgs.runCommand "actual-selfsigned-cert"
      {
        nativeBuildInputs = [ pkgs.openssl ];
      }
      ''
        mkdir -p $out
        openssl req -x509 -nodes -newkey rsa:2048 \
          -keyout $out/key.pem -out $out/cert.pem -days 3650 \
          -subj "/CN=elend" -addext "subjectAltName=DNS:elend"
      '';
in
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
        "${selfSignedCert}/cert.pem:/certs/cert.pem:ro"
        "${selfSignedCert}/key.pem:/certs/key.pem:ro"
      ];
      environment = {
        ACTUAL_HTTPS_CERT = "/certs/cert.pem";
        ACTUAL_HTTPS_KEY = "/certs/key.pem";
      };
      restart = "unless-stopped";
    };
  };

  networking.firewall.allowedTCPPorts = [ 5006 ];
}
