{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "elend";
        "security" = "user";
        "map to guest" = "never";
      };

      pictures = {
        path = "/srv/media/Pictures";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "gleipnir";
        "force user" = "gleipnir";
        "force group" = "users";
      };
    };
  };
}
