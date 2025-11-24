{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 2;
      gaps_out = 5;
      border_size = 1;
      layout = "dwindle";
      allow_tearing = false;

      "col.active_border" = "rgb(c6a0f6) rgb(24273A) rgb(24273A) rgb(c6a0f6) 45deg";
      "col.inactive_border" = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg";
    };

    group = {
      "col.border_active" = "rgb(f38ba8) rgb(24273A) rgb(24273A) rgb(f38ba8) 45deg";
      "col.border_inactive" = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg";

      groupbar = {
        gradients = true;
        gradient_rounding = 7;
        indicator_height = 0;
        gradient_round_only_edges = true;
        "col.active" = "rgb(6c7086)";
        "col.inactive" = "rgb(313244)";
        font_family = "JetBrainsMono Nerd Font";
        font_size = 15;
        height = 20;
      };
  };

  decoration = {
    rounding = 0;
    blur = {
      enabled = false;
      size = 3;
      passes = 1;
      new_optimizations = true;
      vibrancy = 0.1696;
      ignore_opacity = true;
    };
    shadow = {
      enabled = false;
      range = 4;
      render_power = 3;
      color = "rgba(1a1a1aee)";
    };
  };

  animations = {
    enabled = "yes";

    bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };

  dwindle = {
    pseudotile = "yes";
    preserve_split = "yes";
  };

  misc = {
    disable_hyprland_logo = true;
  };
};
}
