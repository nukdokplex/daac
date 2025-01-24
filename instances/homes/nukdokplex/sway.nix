{ lib, config, ... }: {
  wayland.windowManager.sway.config = {
    input = {
      "type:keyboard" = {
        "xkb_layout" = "us,ru";
        "xkb_options" = "grp:ctrl_space_toggle,compose:ralt";
      };
    };
    startup = [
      { command = "'${lib.getExe config.programs.wpaperd.package}' -d"; }
      { command = "firefox"; }
      { command = "telegram-desktop"; }
      { command = "vesktop"; }
      { command = "thunderbird"; }
      { command = "keepassxc"; }
      { command = "spotify"; }
    ];
    assigns = {
      "2" = [{ app_id = "org.telegram.desktop"; } { class = "vesktop"; }];
      "5" = [{ app_id = "thunderbird"; }];
      "7" = [{ app_id = "org.keepassxc.KeePassXC"; }];
      "10" = [{ class = "Spotify"; }];
    };
    floating.criteria = lib.mkAfter [
      { title = "Media viewer"; app_id = "org.telegram.desktop"; }

    ];
    keybindings = with config.wayland.windowManager.sway.config; {
      "${modifier}+u" = "exec firefox";
    };
  };
}
