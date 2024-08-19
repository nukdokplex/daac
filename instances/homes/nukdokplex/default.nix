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


    # TODO move to modules
    packages = with pkgs; [
      vesktop
      telegram-desktop
      logseq
      keepassxc
    ];
  };

  programs.git = {
    userName = "nukdokplex";
    userEmail = "me@nukdokplex.ru";
  };

  wayland.windowManager.hyprland = lib.mkDefault {
    enable = true;

    settings.bind = lib.mkDefault [
      "$mainMod, W, exec, ${lib.getExe pkgs.firefox}"
      "$mainMod, Q, exec, ${lib.getExe pkgs.alacritty}"
      "$mainMod, R, exec, ${lib.getExe pkgs.wofi}"
    ];
  };
}
