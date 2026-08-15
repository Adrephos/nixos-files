{
  config,
  lib,
  ...
}:
{
  imports = [
    ./dotfiles.nix
    ./packages.nix
    ./programs
    ./desktop
  ];

  home = {
    username = lib.mkDefault "gleipnir";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
    };
  };

  programs.home-manager.enable = true;
}
