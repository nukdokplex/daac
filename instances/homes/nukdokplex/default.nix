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

  programs = {
    git = {
      userName = "nukdokplex";
      userEmail = "nukdokplex@nukdokplex.ru";
    };
    pcmanfm.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    # TODO: these packages are hardcoded
    settings.bind = [
      "$mainMod, W, exec, ${lib.getExe pkgs.firefox}"
      "$mainMod, Q, exec, ${lib.getExe pkgs.alacritty}"
      "$mainMod, R, exec, ${lib.getExe pkgs.wofi} --show drun"
      "$mainMod, E, exec, ${lib.getExe pkgs.pcmanfm}"
    ];
  };

  programs.waybar.settings.mainBar = {
    modules-left = [
      "hyprland/workspaces"
      "hyprland/window"
    ];
    modules-center = [ "clock" ];
    modules-right = [ ] ++
      [ "wireplumber" ] ++
      [ "tray" ] ++
      (lib.optional config.programs.waybar.enableBatteryIndicator "battery") ++
      [ "hyprland/language" ]
    ;
  };
}
