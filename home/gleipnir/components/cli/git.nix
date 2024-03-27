{ ... }: {
  programs.git = {
    enable = true;
    userName = "Adrephos";
    userEmail = "adrephos@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
