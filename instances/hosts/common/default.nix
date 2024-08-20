{ config, lib, pkgs, ... }: {
  imports = [
    ./users
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  programs.gamemode.enable = lib.mkDefault true;
  programs.hyprland.enable = lib.mkDefault true;

  services.greetd.settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.hyprland}/bin/Hyprland";
      user = "greeter";
    };
  };
}
