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

    sessionPath = [
      "$HOME/go/bin"
      "$HOME/.cargo/bin"
    ];
  };

  programs.home-manager.enable = true;
}
