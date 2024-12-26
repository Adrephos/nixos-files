{ pkgs, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      configurationLimit = 3;
      theme = pkgs.stdenv.mkDerivation {
        pname = "sekiro_grub_theme";
        version = "1.0";
        src =pkgs.fetchFromGitHub {
          owner = "semimqmo";
          repo = "sekiro_grub_theme";
          rev = "1affe05f7257b72b69404cfc0a60e88aa19f54a6";
          hash = "sha256-wTr5S/17uwQXkWwElqBKIV1J3QUP6W2Qx2Nw0SaM7Qk=";
        };
        installPhase = "cp -r Sekiro $out";
      };
    };
  };
}
