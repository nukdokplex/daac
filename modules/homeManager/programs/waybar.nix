{ pkgs, lib, config, ... }: {
  options = {
    programs.waybar.enableBatteryIndicator = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = {
    programs.waybar = {
      enable = config.wayland.windowManager.hyprland.enable;
      systemd.enable = config.wayland.windowManager.hyprland.enable;

      package = pkgs.waybar;

      settings = {
        mainBar = {
          layer = "bottom";
          postition = "top";
          margin-top = 10;
          margin-bottom = 0; # hyprland already added gap
          margin-left = 10;
          margin-right = 10;
          "hyprland/workspaces" = {
            all-outputs = false;
            format = "{name}";
            disable-scroll = false;
            disable-click = false;
          };
          "hyprland/window" = {
            format = "{class}";
          };
          clock = with config.lib.stylix.colors.withHashtag; {
            format = "{:L%A, %d %B %Y - %H:%M:%S}";
            interval = 1;
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            locale = "ru_RU.UTF-8";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                days = "<span color='${base05}'><b>{}</b></span>";
                months = "<span color='${base0B}'><b>{}</b></span>";
                weeks = "<span color='${base08}'><b>W{}</b></span>";
                weekdays = "<span color='${base08}'><b>{}</b></span>";
                today = "<span color='${base0D}'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
          wireplumber = {
            format = "{volume}% {icon}";
            format-icons = [ "" "" "" ];
            tooltip = true;
            tooltip-format = "{node_name}";
            max-volume = 150.0;
            on-click = lib.getExe pkgs.pavucontrol;
          };
          "hyprland/language" = {
            format = "{}";
            format-en = "EN";
            format-ru = "RU";
          };
        };
      };
    };
  };
}
