{ self, config, lib, pkgs, ... }:
let
  wofi-power-menu = self.inputs.wofi-power-menu.packages.${pkgs.system}.wofi-power-menu;
  keySynonims = {
    directions = rec {
      Left = {
        direction = "l";
        resizeVector = { x = -1; y = 0; };
      };
      H = Left;
      Right = {
        direction = "r";
        resizeVector = { x = 1; y = 0; };
      };
      L = Right;
      Up = {
        direction = "u";
        resizeVector = { x = 0; y = -1; };
      };
      K = Up;
      Down = {
        direction = "d";
        resizeVector = { x = 0; y = 1; };
      };
      J = Down;
    };
    numbersNormal = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ];
    numbersNumpad = [ "KP_End" "KP_Down" "KP_Next" "KP_Left" "KP_Begin" "KP_Right" "KP_Home" "KP_Up" "KP_Prior" "KP_Insert" ];
  };
  resizeModifier = 60;
  generateDirectionBinds = fn: (lib.attrsets.mapAttrsToList (key: props: (fn { inherit key; inherit (props) direction; resizeX = builtins.toString (props.resizeVector.x * resizeModifier); resizeY = builtins.toString (props.resizeVector.y * resizeModifier); })) keySynonims.directions);
  generateWorkspaceBinds = fn: ((lib.lists.imap1 (i: key: (fn i key)) keySynonims.numbersNormal) ++ (lib.lists.imap1 (i: key: (fn i key)) keySynonims.numbersNumpad));
in
{
  options.custom.hyprland.enable = lib.mkEnableOption "Hyprland configuration";

  config = lib.mkIf config.custom.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = self.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      settings = {
        "$mainMod" = "SUPER";
        # autostarts
        exec-once = [
          "'${lib.getExe pkgs.soteria}'"
        ];

        # inputs
        input = {
          follow_mouse = 1;
          touchpad = {
            clickfinger_behavior = true;
            drag_lock = true;
            natural_scroll = true;
            tap-to-click = true;
          };

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          numlock_by_default = true;
        };
        gestures.workspace_swipe = true;

        # layouts
        dwindle = {
          pseudotile = true;
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

        bindd = [
          "Control_L Alt_L, Delete, Open power menu, exec, '${lib.getExe' wofi-power-menu "wofi-power-menu"}'"
          "$mainMod, P, Screenshot screen region, exec, '${lib.getExe pkgs.grim}' -g \"$('${lib.getExe pkgs.slurp}')\" -l 6 -t png - | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'"
          "$mainMod Shift_L, P, Screenshot active output, exec, '${lib.getExe pkgs.grim}' -c -l 6 -t png -o \"$('${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"}' activeworkspace -j | '${lib.getExe pkgs.jq}' -r .monitor))\" - | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'"
          "$mainMod, T, Open clipboard history, exec, '${lib.getExe config.services.cliphist.package}' list | '${lib.getExe config.programs.wofi.package}' --dmenu -p 'Select clipboard history entry...' | '${lib.getExe config.services.cliphist.package}' decode | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'"
          "$mainMod, Insert, Enable passthrough mode (disable all binds except this one to disable), submap, passthrough"
          "$mainMod, O, Open file manager, exec, '${lib.getExe pkgs.xfce.thunar}'"
          "$mainMod, Return, Open console, exec, '${lib.getExe config.programs.alacritty.package}'"
          "$mainMod Shift_L, Q, Close active window, killactive"
          "$mainMod, Z, Toggle split (top/side) of the current window, togglesplit"
          "$mainMod, F, Toggle window fullscreen, fullscreen"
          "$mainMod Shift_L, F, Toggle fake fullscreen, fullscreenstate, 0 3"
          "$mainMod, Space, Toggle window floating, togglefloating"
          "$mainMod, D, Run drun menu, exec, '${lib.getExe config.programs.wofi.package}' --show drun"
        ]
        ++ generateDirectionBinds ({ key, direction, ... }: "$mainMod, ${key}, Move focus, movefocus, ${direction}")
        ++ generateDirectionBinds ({ key, direction, ... }: "$mainMod Shift_L, ${key}, Move window around, swapwindow, ${direction}")
        ++ generateDirectionBinds ({ key, resizeX, resizeY, ... }: "$mainMod Control_L, ${key}, Resize window, resizeactive, ${builtins.toString resizeX} ${builtins.toString resizeY}")
        ++ generateWorkspaceBinds (i: key: "$mainMod, ${key}, Switch to workspace ${builtins.toString i}, workspace, ${builtins.toString i}")
        ++ generateWorkspaceBinds (i: key: "$mainMod Alt_L, ${key}, Switch to workspace ${builtins.toString (10+i)}, workspace, ${builtins.toString (10+i)}")
        ++ generateWorkspaceBinds (i: key: "$mainMod Shift_L, ${key}, Move active window to workspace ${builtins.toString i}, movetoworkspace, ${builtins.toString i}")
        ++ generateWorkspaceBinds (i: key: "$mainMod Shift_L Alt_L, ${key}, Move window to workspace ${builtins.toString (10+i)}, movetoworkspace, ${builtins.toString (10+i)}");

        # binds
        binddm = [
          "$mainMod, mouse:272, Move window, movewindow"
          "$mainMod, mouse:273, Resize window, resizewindow"
        ];

        binddel = [
          ", XF86AudioRaiseVolume, Increase volume for default sink, exec, '${lib.getExe' pkgs.wireplumber "wpctl"}' set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, Decrease volume for default sink, exec, '${lib.getExe' pkgs.wireplumber "wpctl"}' set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessDown, Decrease screen brightness, exec, '${lib.getExe pkgs.brightnessctl}' set 10%-"
          ", XF86MonBrightnessUp, Increase screen brightness, exec, '${lib.getExe pkgs.brightnessctl}' set 10%+"
        ];

        binddl = [
          ", XF86AudioMute, Mute default sink, exec, '${lib.getExe' pkgs.wireplumber "wpctl"}' set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, Toggle play/pause for playback, exec, '${lib.getExe pkgs.playerctl}' play-pause"
          ", XF86AudioPrev, Previous media in playlist, exec, '${lib.getExe pkgs.playerctl}' previous"
          ", XF86AudioNext, Next media in playlist, exec, '${lib.getExe pkgs.playerctl}' next"
          "$mainMod, M, Toggle mute for default audio sink, exec, '${lib.getExe' pkgs.wireplumber "wpctl"}' set-mute @DEFAULT_AUDIO_SINK@ toggle"
          "$mainMod Shift_L, M, Toggle mute for default audio source, exec, '${lib.getExe' pkgs.wireplumber "wpctl"}' set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

        layerrule = [
          "noanim, selection" # disable animation for some utilities like slurp
        ];

        # window rules
        windowrulev2 = [
          # network manager applet
          "float, class:nm-connection-editor"

          # qbittorrent
          "float, class:org.qbittorrent.qBittorrent, title:negative:(qBittorrent)(.*)"
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
        enableXdgAutostart = true;
        variables = [
          "GDK_BACKEND"
          "QT_QPA_PLATFORM"
          "QT_QPA_PLATFORMTHEME"
          # "SDL_VIDEODRIVER"
          # "CLUTTER_BACKEND"
          "DESKTOP_SESSION"
          "WLR_DRM_NO_ATOMIC"
          "NIXOS_OZONE_WL"
        ];
      };
    };
    services.cliphist.enable = true;
    programs.hyprlock = {
      enable = true;
      package = self.inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };
      };
    };
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings.mainBar = {
        modules-left = lib.mkBefore [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-right = lib.mkAfter [
          "hyprland/language"
        ];
      };
    };
    services.swaync.enable = true;
    programs.wofi.enable = true;
    services.hypridle = {
      enable = true;
      package = self.inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          before_sleep_cmd = "loginctl lock-session";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock --immediate --no-fade-in";
        };
        listener =
          let
            cfg = config.custom.hypridle.timeouts;
          in
          [ ]
          ++ lib.optional (cfg.kbd_backlight > -1) {
            timeout = cfg.kbd_backlight;
            on-timeout = "'${lib.getExe pkgs.brightnessctl}' -sd chromeos::kbd_backlight set 0";
            on-resume = "'${lib.getExe pkgs.brightnessctl}' -rd chromeos::kbd_backlight";
          }
          ++ lib.optional (cfg.dim_backlight > -1) {
            timeout = cfg.dim_backlight;
            on-timeout = "'${lib.getExe pkgs.brightnessctl}' -s set 10";
            on-resume = "'${lib.getExe pkgs.brightnessctl}' -r";
          }
          ++ lib.optional (cfg.off_backlight > -1) {
            timeout = cfg.off_backlight;
            on-timeout = "'${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"}' dispatch dpms off";
            on-resume = "'${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"}' dispatch dpms on";
          }
          ++ lib.optional (cfg.lock > -1) {
            timeout = cfg.lock;
            on-timeout = "'${lib.getExe' pkgs.systemd "loginctl"}' lock-session";
          }
          ++ lib.optional (cfg.suspend > -1) {
            timeout = cfg.suspend;
            on-timeout = "'${lib.getExe' pkgs.systemd "systemctl"}' suspend";
          };
      };
    };
    xdg.configFile."wofi-power-menu.toml" = {
      enable = true;
      target = "wofi-power-menu.toml";
      source = (pkgs.formats.toml { }).generate "wofi-power-menu.toml" {
        menu = {
          shutdown = {
            enabled = "true";
            title = "Power off";
            cmd = "systemctl poweroff";
          };

          reboot = {
            enabled = "true";
            title = "Reboot";
            cmd = "systemctl reboot";
          };

          suspend = {
            enabled = "true";
            title = "Suspend";
            cmd = "systemctl suspend";
          };

          hibernate = {
            enabled = "true";
            title = "Hibernate";
            cmd = "systemctl hibernate";
          };

          logout = {
            enabled = "true";
            title = "Logout";
            cmd = "hyprctl dispatch exit";
          };

          lock-screen = {
            enabled = "true";
            title = "Lock";
            cmd = "loginctl lock-session";
          };
        };
      };
    };
  };
}
