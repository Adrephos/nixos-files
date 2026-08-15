{ pkgs, ... }:
let
  sddm-theme = pkgs.fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "c10bd950544036c7418e0f34cbf1b597dae2b72f";
    sha256 = "sha256-ITufiMTnSX9cg83mlmuufNXxG1dp9OKG90VBZdDeMxw=";
  };
in
{
  services = {
    xserver.enable = true;
    gnome.gnome-keyring.enable = true;

    displayManager = {
      defaultSession = "niri";
      sddm = {
        enable = true;
        theme = "${sddm-theme}";
        extraPackages = with pkgs.kdePackages; [ qtmultimedia ];
      };
    };
  };

  programs = {
    niri.enable = true;
    kdeconnect.enable = true;
    command-not-found.enable = true;
  };
}
