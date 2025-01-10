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

    services.blueman.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    services.tumbler.enable = true;
    programs.via.enable = true;
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
