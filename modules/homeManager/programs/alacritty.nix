{ lib, config, pkgs, ... }: {
  programs.alacritty = lib.mkDefault {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      font.normal = {
        family = "JetBrainsMono Nerd Font Mono";
        size = 14;
      };
    };
  };
}
