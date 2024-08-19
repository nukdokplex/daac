{ lib, config, ... }: {
  programs.mangohud = lib.mkDefault {
    settings = {
      full = true;
      toggle_hud = "Shift_R+F12";
    };
  };
}