{ lib
, pkgs
, ...
}: {
  imports = [
    ./users
    ./secrets
    ./networkManagerProfiles.nix
    ./stylix.nix
  ];
  config = lib.mkDefault {
    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;

    programs.gamemode.enable = true;
    programs.hyprland.enable = true;

    services.blueman.enable = true;

    services.greetd.settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "greeter";
      };
    };

    nix = {
      gc = {
        automatic = true;
        dates = "daily";
        options = ''
          --delete-older-than 30d
        '';
        persistent = true;
        randomizedDelaySec = "60min";
      };
      extraOptions = ''
        min-free = ${toString (100 * 1024 * 1024)}
        max-free = ${toString (1024 * 1024 * 1024)}
      '';
      optimise.automatic = true;

      settings = {
        auto-optimise-store = false;
        experimental-features = [ "nix-command" "flakes" ];
      };
    };
  };
}
