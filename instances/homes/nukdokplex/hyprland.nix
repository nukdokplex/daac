{ pkgs, lib, ... }: {
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, U, exec, firefox"
        "$mainMod, I, exec, alacritty"
        "$mainMod, N, exec, alacritty -- ranger"
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
        "workspace 3 silent, class:(codium-url-handler)"
      ];
    };
  };
}
