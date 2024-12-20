{ pkgs, config, lib, self, ... }:
let
  isEnabled = config.wayland.windowManager.sway.enable;
  clamp = value: min: max: lib.trivial.max min (lib.trivial.min value max);
  wofi-power-menu = self.inputs.wofi-power-menu.packages.${pkgs.stdenv.hostPlatform.system}.wofi-power-menu;
in
{
  config.wayland.windowManager.sway = {
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      gaps.inner = 10;
      gaps.outer = 10;
      bars = [ ];
      window.border = config.custom.borders.width;
      floating.border = window.border;
      keybindings = lib.mkOptionDefault {
        "Ctrl+Alt+Delete" = "exec '${lib.getExe' wofi-power-menu "wofi-power-menu"}'";
        "${modifier}+P" = "exec '${lib.getExe pkgs.grim}' -g $('${lib.getExe pkgs.slurp}') -l 6 -t png - | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'";
        "${modifier}+Shift+P" = "exec ${lib.getExe pkgs.grim} -c -l 6 -t png -o \"$('${lib.getExe' pkgs.sway "swaymsg"}') -t get_workspaces | jq -r '.[] | select(.focused==true).output')\" - | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'";
        "${modifier}+v" = "exec '${lib.getExe pkgs.cliphist}' list | '${lib.getExe pkgs.wofi}' --dmenu -p \"Select clipboard history entry...\" | '${lib.getExe pkgs.cliphist}' decode | '${lib.getExe' pkgs.wl-clipboard "wl-copy"}'";
      };
      startup = [
        { command = "'${lib.getExe pkgs.soteria}'"; }
        { command = "'${lib.getExe pkgs.wayvnc}' -r 127.0.0.1"; }
      ];
    };
  };

  config.home.packages = lib.mkIf isEnabled (with pkgs; [
    grim
    slurp
    wl-clipboard
    wayvnc
    soteria
    wofi-power-menu
  ]);

  config.custom.borders.radius = lib.mkIf isEnabled (lib.mkDefault 0);
  config.xdg.configFile."wofi-power-menu.toml" = lib.mkIf isEnabled {
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

  config.programs.wofi = lib.mkIf isEnabled {
    enable = true;
  };

  config.services.cliphist = lib.mkIf isEnabled {
    enable = true;
    allowImages = true;
  };

  config.services.swayidle = lib.mkIf isEnabled {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      { event = "lock"; command = "lock"; }
    ];
  };

  config.programs.swaylock = lib.mkIf isEnabled {
    enable = true;
  };

  config.services.swaync = lib.mkIf isEnabled {
    enable = true;
  };

  config.programs.waybar.settings.mainBar = lib.mkIf isEnabled {
    modules-left = lib.mkBefore [
      "sway/workspaces"
      "sway/window"
      "sway/mode"
    ];
    modules-right = lib.mkAfter [
      "sway/language"
    ];
  };
}
