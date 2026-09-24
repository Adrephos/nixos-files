{ pkgs, ... }:
{
  programs.anki = {
    package = pkgs.callPackage ../../../pkgs/anki/package.nix { };
    videoDriver = "software";
  };
}
