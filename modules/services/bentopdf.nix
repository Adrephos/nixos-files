{
  services.bentopdf = {
    enable = true;
    domain = "pdf.adrephos.com";
    nginx = {
      enable = true;
      virtualHost = {
        useACMEHost = "adrephos.com";
        forceSSL = true;
      };
    };
  };
}
