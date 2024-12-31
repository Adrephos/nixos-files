{ ... }: {
  programs.git = {
    enable = true;
    userName = "Juan A.";
    userEmail = "adrephos@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
