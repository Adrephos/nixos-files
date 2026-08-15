{ ... }:
{
  programs.git = {
    enable = true;
    signing.format = "openpgp";
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Juan A.";
        email = "adrephos@gmail.com";
      };
    };
  };
}
