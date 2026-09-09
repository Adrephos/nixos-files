{ inputs, pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      eza
      zoxide
      p7zip
      btop
      ncdu
      bat
      socat
      jq
      fastfetch
      brightnessctl
      fzf
      onefetch
      wget
      loupe
      feh
      timer
      lolcat
      glow
      google-cloud-sdk-gce
      gum
      ueberzugpp
      posting
      lazygit
      lazysql
      gopls
      gcc

      # System maintenance
      just
      nh

      # Fonts
      nerd-fonts.jetbrains-mono
      librsvg
      awatcher
    ])
    ++ [
      inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.sonora.packages.${pkgs.stdenv.hostPlatform.system}.default
      (inputs.helium2nix.helium.${pkgs.stdenv.hostPlatform.system} {
        commandLineArgs = [ "--ozone-platform=x11" ];
      })
    ];
}
