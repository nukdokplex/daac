{ pkgs, config, lib, self, ... }:
let
  wofi-power-menu = self.inputs.wofi-power-menu.packages.${pkgs.stdenv.hostPlatform.system}.wofi-power-menu;
in
{
  options.custom.sway.enable = lib.mkEnableOption "custom sway configuration";

  config = lib.mkIf config.custom.sway.enable {
    wayland.windowManager.sway = {
      config = rec {
        modifier = "Mod4";
        left = "h";
        right = "l";
        up = "k";
        down = "j";
        terminal = "alacritty";
        menu = "'${lib.getExe pkgs.wofi}' --show drun";
        defaultWorkspace = "workspace number 1";

        gaps.inner = 10;
        gaps.outer = 10;
        bars = [ ];
        window.border = config.custom.borders.width;
        floating.border = window.border;

        bindkeysToCode = true;
        keybindings = {
          "Ctrl+Alt+Delete" = "exec '${lib.getExe' wofi-power-menu "wofi-power-menu"}'";
          "${modifier}+p" = "exec '${lib.getExe pkgs.grim}' -g \"$('${lib.getExe pkgs.slurp}')\" -l 6 -t png - | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'";
          "${modifier}+Shift+p" = "exec '${lib.getExe pkgs.grim}' -c -l 6 -t png -o \"$('${lib.getExe' pkgs.sway "swaymsg"}' -t get_workspaces | '${lib.getExe pkgs.jq}' -r '.[] | select(.focused==true).output')\" - | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'";
          "${modifier}+t" = "exec '${lib.getExe pkgs.cliphist}' list | '${lib.getExe pkgs.wofi}' --dmenu -p \"Select clipboard history entry...\" | '${lib.getExe pkgs.cliphist}' decode | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'";
          "${modifier}+Insert" = "mode passthrough; floating_modifier none";
          "${modifier}+o" = "exec '${lib.getExe pkgs.xfce.thunar}'";

          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec ${menu}";

          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${right}" = "move right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+Ctrl+${left}" = "resize shrink width 10 px";
          "${modifier}+Ctrl+${down}" = "resize grow height 10 px";
          "${modifier}+Ctrl+${up}" = "resize shrink height 10 px";
          "${modifier}+Ctrl+${right}" = "resize grow width 10 px";

          "${modifier}+Ctrl+Left" = "resize shrink width 10 px";
          "${modifier}+Ctrl+Down" = "resize grow height 10 px";
          "${modifier}+Ctrl+Up" = "resize shrink heigt 10 px";
          "${modifier}+Ctrl+Right" = "resize grow width 10 px";

          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+a" = "focus parent";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Alt+1" = "workspace number 11";
          "${modifier}+Alt+2" = "workspace number 12";
          "${modifier}+Alt+3" = "workspace number 13";
          "${modifier}+Alt+4" = "workspace number 14";
          "${modifier}+Alt+5" = "workspace number 15";
          "${modifier}+Alt+6" = "workspace number 16";
          "${modifier}+Alt+7" = "workspace number 17";
          "${modifier}+Alt+8" = "workspace number 18";
          "${modifier}+Alt+9" = "workspace number 19";
          "${modifier}+Alt+0" = "workspace number 20";

          "${modifier}+Shift+1" = "move container to workspace number 1; workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2; workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3; workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4; workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5; workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6; workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7; workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8; workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9; workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10; workspace number 10";

          "${modifier}+Shift+Alt+1" = "move container to workspace number 11; workspace number 11";
          "${modifier}+Shift+Alt+2" = "move container to workspace number 12; workspace number 12";
          "${modifier}+Shift+Alt+3" = "move container to workspace number 13; workspace number 13";
          "${modifier}+Shift+Alt+4" = "move container to workspace number 14; workspace number 14";
          "${modifier}+Shift+Alt+5" = "move container to workspace number 15; workspace number 15";
          "${modifier}+Shift+Alt+6" = "move container to workspace number 16; workspace number 16";
          "${modifier}+Shift+Alt+7" = "move container to workspace number 17; workspace number 17";
          "${modifier}+Shift+Alt+8" = "move container to workspace number 18; workspace number 18";
          "${modifier}+Shift+Alt+9" = "move container to workspace number 19; workspace number 19";
          "${modifier}+Shift+Alt+0" = "move container to workspace number 20; workspace number 20";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+Shift+c" = "reload";

          "${modifier}+r" = "mode resize";
        };
        modes = {
          resize = {
            "${left}" = "resize shrink width 10 px";
            "${down}" = "resize grow height 10 px";
            "${up}" = "resize shrink height 10 px";
            "${right}" = "resize grow width 10 px";
            "Left" = "resize shrink width 10 px";
            "Down" = "resize grow height 10 px";
            "Up" = "resize shrink height 10 px";
            "Right" = "resize grow width 10 px";
            "Escape" = "mode default";
            "Return" = "mode default";
          };
          passthrough = {
            "${modifier}+Insert" = "mode default; floating_modifier ${modifier} normal";
          };
        };
        startup = lib.mkBefore [
          { command = "'${lib.getExe pkgs.soteria}'"; }
          { command = "'${lib.getExe pkgs.wayvnc}' -r 127.0.0.1"; }
        ];
      };
    };
    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard
      wayvnc
      soteria
      wofi-power-menu
    ];

    xdg.configFile."wofi-power-menu.toml" = {
      enable = true;
      target = "wofi-power-menu.toml";
      source = (pkgs.formats.toml { }).generate "wofi-power-menu.toml" {
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
    programs.wofi.enable = true;
    services.cliphist.enable = true;

    programs.waybar.settings.mainBar = {
      modules-left = lib.mkBefore [
        "sway/workspaces"
        "sway/window"
        "sway/mode"
      ];
      modules-right = lib.mkAfter [
        "sway/language"
      ];
    };
  };
}
