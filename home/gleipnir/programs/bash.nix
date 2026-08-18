{
  programs.bash = {
    enable = true;

    shellAliases = {
      ls = "ls -a --color=auto";
      ll = "ls -lah --color=auto";
    };
  };
}
