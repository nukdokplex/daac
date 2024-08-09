{ self, config, lib, pkgs, ... }:
let
  username = "nukdokplex";
in
{
  imports = [
    self.modules.homeManager.default
  ];

  home = {
    stateVersion = "24.05"; # TODO: dehardcodify 
    homeDirectory = "/home/${username}";
    inherit username;

    packages = with pkgs; [
      vesktop
      telegram-desktop
      logseq
      keepassxc
    ];
  };

  # there the magic starts
  cor.home = {
    desktop.hyprland.enable = true;
    apps = {
      alacritty.enable = true;
      firefox.enable = true;
      gaming.enable = true; # includes lutris, mangohud, r2modman, steam and wine
      hyprpicker.enable = true;
      hyprshot.enable = true;
      hyprlock.enable = true;
      nheko.enable = true;
      pcmanfm-qt.enable = true;
      rofi.enable = true;
      spicetify.enable = true;
      vscodium.enable = true;
    };
  };
}
