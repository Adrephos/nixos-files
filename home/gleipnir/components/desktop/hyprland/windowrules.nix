{ ... }:
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
      name = "Picture-in-Picture";
      "match:title" = "^([Pp]icture[- ]in[- ][Pp]icture)$";
      float = true;
      pin = true;
      size = "454 255";
      move = "monitor_w-454 (monitor_h/2)-(255/2)";
      keep_aspect_ratio = true;
    }
    {
      name = "File chooser";
      "match:title" = "^(([Ss]ave|[Oo]pen) [Ff]ile|.* wants to (save|open))$";
      float = true;
      size = "1200 700";
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
  ];
}
