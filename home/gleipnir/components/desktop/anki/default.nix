{ pkgs, ... }: {

  programs.anki = {
    package = pkgs.anki-bin;
    videoDriver = "software";
  };
}
