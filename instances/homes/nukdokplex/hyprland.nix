{ lib, ... }: {
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        kb_layout = "us,ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:ctrl_space_toggle,compose:ralt";
        kb_rules = "";
      };

      bindd = [
        "$mainMod, U, Run browser, exec, firefox"
      ];

      exec-once = lib.mkAfter [
        "[workspace 1 silent] firefox"
        "[workspace 2 silent] telegram-desktop"
        "[workspace 2 silent] vesktop"
        "[workspace 5 silent] thunderbird"
        "[workspace 7 silent] keepassxc"
        "[workspace 10 silent] spotify"
      ];

      windowrulev2 = [
        "workspace 2 silent, class:(vesktop)"
      ];
    };
  };
}
