{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "floating-class";
      "match:class" = "^(com.adrephos.floating)";
      float = true;
      size = "1200 700";
    }
    {
      name = "steam";
      "match:class" = "^(steam)$";
      tile = true;
      workspace = "9 silent";
    }
    {
      name = "discord";
      "match:class" = "^(discord)$";
      workspace = "1 silent";
    }
    {
      name = "discord";
      "match:class" = "^(discord)$";
      workspace = "1 silent";
    }
    {
      name = "Picture-in-Picture";
      "match:title" = "^(Picture-in-Picture)$";
      float = true;
      pin = true;
    }
    {
      name = "scrcpy";
      "match:class" = "^(.scrcpy-wrapped)$";
      tile = true;
      pin = true;
    }
    {
      name = "boosteroid";
      "match:class" = "^(Boosteroid)$";
      idle_inhibit = "fullscreen";
    }
    {
      name = "ueberzugpp";
      "match:class" = "^(ueberzugpp).*$";
    }
    {
      name = "terrara";
      "match:class" = "^(Terraria.bin.x86_6)$";
      fullscreen = true;
    }
  ];
}
