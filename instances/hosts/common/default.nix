{ config, lib, pkgs, ... }: {
  imports = [
    ./users
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  programs.gamemode.enable = lib.mkDefault true;
  programs.hyprland.enable = lib.mkDefault true;

  services.greetd.settings = rec {
    initial_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = "nukdokplex";
    };
    default_session = initial_session;
  };
}
