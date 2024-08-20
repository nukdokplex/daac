{ lib, config, ... }: {
  programs.mangohud = {
    settings = {
      full = true;
      toggle_hud = "Shift_R+F12";
    };
  };
}