{ config, lib, ... }: {
  imports = [
    ./users
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  programs.gamemode.enable = lib.mkDefault true;
  programs.hyprland.enable = lib.mkDefault true;
}