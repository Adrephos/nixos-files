{ pkgs, ... }:
{
  programs.anki = {
    package = pkgs.anki;
    videoDriver = "software";
  };
}
