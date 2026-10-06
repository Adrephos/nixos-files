{ pkgs, inputs, ... }:
{
  programs.anki = {
    package = inputs.anki-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
    videoDriver = "software";
  };
}
