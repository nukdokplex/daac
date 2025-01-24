{ lib, pkgs, config, ... }:
let
  mkTimeoutOption = name: lib.mkOption {
    default = -1;
    description = "Time in seconds to trigger ${name}";
  };
in
{
  options.custom.hypridle.timeouts = {
    kbd_backlight = mkTimeoutOption "kbd_backlight off";
    dim_backlight = mkTimeoutOption "dim backlight";
    off_backlight = mkTimeoutOption "off backlight";
    lock = mkTimeoutOption "lock";
    suspend = mkTimeoutOption "suspend";
  };
  # configuration of hypridle is delegated to window manager modules, e.g. hyprland or sway
}
