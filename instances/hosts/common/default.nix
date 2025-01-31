{ lib, pkgs, self, ... }: {
  imports = [
    ./users
    ./secrets
    ./networkManagerProfiles.nix
    ./stylix.nix
    ./zapret.nix
  ];
  config = {
    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;

    hardware.usb-modeswitch.enable = true; # i need this because i have huawei e8372 wingle
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

    services.pipewire = {
      enable = true;
      jack.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "common-settings" = {
            "context.properties" = {
              "log.level" = "D";
              "device.restore-profile" = true;
            };
          };
        };
      };
    };

    programs.hyprland = let system = pkgs.stdenv.hostPlatform.system; in {
      package = self.inputs.hyprland.packages.${system}.hyprland;
      portalPackage = self.inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };

    services.yggdrasil = {
      enable = true;
      openMulticastPort = true;
      settings = {
        Peers = [ ];
        IntefacePeers = { };
        Listen = [ "tls://[::]:33777" ];
      };
    };

    networking.firewall.allowedTCPPorts = [ 33777 ];

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
