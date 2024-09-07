{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
  wofi-power-menu = lib.getExe' self.inputs.wofi-power-menu.packages.${pkgs.system}.wofi-power-menu "wofi-power-menu";
in {
  config.wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      # autostarts
      exec-once = [
        "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"
      ];

      # inputs
      input = {
        kb_layout = "us,ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:lalt_lshift_toggle";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          clickfinger_behavior = true;
          drag_lock = true;
          middle_button_emulation = true;
          natural_scroll = true;
          tap-to-click = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        numlock_by_default = true;
      };
      gestures.workspace_swipe = true;

      # layouts
      dwindle = {
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this

        # force_split values
        # 0 -> split follows mouse,
        # 1 -> always split to the left (new = left or top)
        # 2 -> always split to the right (new = right or bottom)
        force_split = 2;
      };

      # general
      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = config.custom.borders.width;
        layout = "dwindle";
        allow_tearing = false;
      };

      # binds
      bind = let
        jq = lib.getExe pkgs.jq;
      in [
        "$mainMod, C, killactive"
        "$mainMod SHIFT, C, exec, hyprctl reload"
        "$mainMod, M, exit"
        "$mainMod, P, pseudo"
        "$mainMod, Z, togglesplit"
        "$mainMod, L, exec, loginctl lock-session"
        "$mainMod, D, togglefloating"
        "$mainMod, F, fullscreen"
        "$mainMod SHIFT, F, fakefullscreen"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, V, exec, cliphist list | wofi --dmenu -p \"Select clipboard history entry...\" | cliphist decode | wl-copy"
        "$mainMod, PRINT, exec, grim -g \"$(slurp)\" -l 6 -t png - | wl-copy"
        ", PRINT, exec, grim -c -l 6 -t png -o \"$(hyprctl activeworkspace -j | ${jq} -r .monitor)\" - | wl-copy"
        "CTRL ALT, DELETE, exec, ${wofi-power-menu}"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Moving windows
        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        # Window resizing                     X  Y
        "$mainMod CTRL, left, resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive, 60 0"
        "$mainMod CTRL, up, resizeactive, 0 -60"
        "$mainMod CTRL, down, resizeactive, 0 60"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Switch workspaces with mainMod + numpad [0-9]
        "$mainMod, KP_End, workspace, 1"
        "$mainMod, KP_Down, workspace, 2"
        "$mainMod, KP_Next, workspace, 3"
        "$mainMod, KP_Left, workspace, 4"
        "$mainMod, KP_Begin, workspace, 5"
        "$mainMod, KP_Right, workspace, 6"
        "$mainMod, KP_Home, workspace, 7"
        "$mainMod, KP_Up, workspace, 8"
        "$mainMod, KP_Prior, workspace, 9"
        "$mainMod, KP_Insert, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + Numpad [0-9]
        "$mainMod SHIFT, KP_End, movetoworkspace, 1"
        "$mainMod SHIFT, KP_Down, movetoworkspace, 2"
        "$mainMod SHIFT, KP_Next, movetoworkspace, 3"
        "$mainMod SHIFT, KP_Left, movetoworkspace, 4"
        "$mainMod SHIFT, KP_Begin, movetoworkspace, 5"
        "$mainMod SHIFT, KP_Right, movetoworkspace, 6"
        "$mainMod SHIFT, KP_Home, movetoworkspace, 7"
        "$mainMod SHIFT, KP_Up, movetoworkspace, 8"
        "$mainMod SHIFT, KP_Prior, movetoworkspace, 9"
        "$mainMod SHIFT, KP_Insert, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} set 10%-"
        ", XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} set 10%+"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      layerrule = [
        "noanim, selection" # disable animation for some utilities like slurp
      ];

      # window rules
      windowrulev2 = [
        # xwaylandvideobridge
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"

        # firefox picture-in-picture
        "float, class:(firefox), title:^(Picture-in-Picture)$"
        "pin, class:(firefox), title:^(Picture-in-Picture)$"
        "bordercolor rgba(ff0000ff), class:(firefox), title:^(Picture-in-Picture)$"
        "float, class:(firefox), title:^(Картинка в картинке)$"
        "pin, class:(firefox), title:^(Картинка в картинке)$"
        "bordercolor rgba(ff0000ff), class:(firefox), title:^(Картинка в картинкеx)$"

        # network manager applet
        "float, class:(nm-connection-editor)"

        # pcmanfm-qt
        "float, class:(pcmanfm-qt), title:(Копирование файлов)"

        # steam tweaks
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];

      # appearance
      decoration = {
        rounding = config.custom.borders.radius;

        blur = {
          enabled = true;
          size = 5;
          passes = 4;
          new_optimizations = true;
        };

        drop_shadow = false;
        shadow_range = 15;
        shadow_render_power = 3;

        dim_inactive = false;
        dim_strength = 0.2;
      };

      animations = {
        enabled = true;

        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92 "
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1" # use with .2s duration
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          # "layers, 1, 2, md3_decel, slide"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          # "workspaces, 1, 2.5, softAcDecel, slide"
          # "workspaces, 1, 7, menu_decel, slidefade 15%"
          # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      xwayland.force_zero_scaling = true;

      env = [
        # GTK
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"

        # "SDL_VIDEODRIVER,x11"
        # "CLUTTER_BACKEND,x11"

        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        "DESKTOP_SESSION,hyprland"

        "WLR_DRM_NO_ATOMIC,1"

        "NIXOS_OZONE_WL,1"
      ];
    };

    systemd = {
      enable = true;
      enableXdgAutostart = false;
      variables = [
        "GDK_BACKEND"
        "QT_QPA_PLATFORM"
        # "SDL_VIDEODRIVER"
        # "CLUTTER_BACKEND"
        "DISPLAY"
        "WAYLAND_DISPLAY"
        "DESKTOP_SESSION"
        "WLR_DRM_NO_ATOMIC"
        "NIXOS_OZONE_WL"
      ];
    };
  };

  config.services.cliphist = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;
    allowImages = true;
  };

  config.home.packages = lib.mkIf config.wayland.windowManager.hyprland.enable [
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
  ];

  config.programs.wofi = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;
    package = pkgs.wofi;
  };

  config.xdg.configFile."wofi-power-menu.toml" = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;
    target = "wofi-power-menu.toml";
    source = (pkgs.formats.toml {}).generate "wofi-power-menu.toml" {
      wofi = {
        path = lib.getExe pkgs.wofi;
      };

      menu.shutdown = {
        enabled = "true";
        title = "Power off";
        cmd = "systemctl poweroff";
      };

      menu.reboot = {
        enabled = "true";
        title = "Reboot";
        cmd = "systemctl reboot";
      };

      menu.suspend = {
        enabled = "true";
        title = "Suspend";
        cmd = "systemctl suspend";
      };

      menu.hibernate = {
        enabled = "true";
        title = "Hibernate";
        cmd = "systemctl hibernate";
      };

      menu.logout = {
        enabled = "true";
        title = "Logout";
        cmd = "hyprctl dispatch exit";
      };

      menu.lock-screen = {
        enabled = "true";
        title = "Lock";
        cmd = "loginctl lock-session";
      };
    };
  };

  config.programs.swaylock = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;
    package = pkgs.swaylock;
  };

  config.services.hypridle = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof swaylock || swaylock";
        unlock_cmd = "killall swaylock";
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = let
        cfg = config.idling-settings;
      in
        []
        ++ (lib.optional (cfg.lockSessionTimeout > -1) {
          timeout = cfg.lockSessionTimeout;
          on-timeout = "loginctl lock-session";
        })
        ++ (lib.optional (cfg.screenOffTimeout > -1) {
          timeout = cfg.screenOffTimeout;
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        })
        ++ (lib.optional (cfg.suspendTimeout > -1) {
          timeout = cfg.suspendTimeout;
          on-timeout = "systemctl suspend";
        });
    };
  };
}
