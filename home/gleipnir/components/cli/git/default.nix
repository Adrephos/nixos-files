{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Juan A.";
        email = "adrephos@gmail.com";
      };
    };
  };
}
