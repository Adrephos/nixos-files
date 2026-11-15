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

    dbus.packages = [ pkgs.gnome-control-center ];

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
    niri = {
      enable = true;
      package = pkgs.niri.overrideAttrs (old: rec {
        version = "26.04-main-689c1e9";
        src = pkgs.fetchFromGitHub {
          owner = "niri-wm";
          repo = "niri";
          rev = "689c1e914a5af782a476e433b79c15554bf5a312";
          hash = "sha256-13a2sg+XKWFg+c2jCNTnso+Qbuihy6YHK2awm54VLrc=";
        };
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit src;
          name = "niri-main-vendor";
          hash = "sha256-rLVTigIUf8rxn25bVdjVyOqPPjBq8KpKINoXQ/gFYxI=";
        };
        doCheck = false;
        doInstallCheck = false;
      });
    };
    kdeconnect.enable = true;
    command-not-found.enable = false;
  };
}
