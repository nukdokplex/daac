{ pkgs, config, lib, ... }: {
  options.custom.steam.enable = lib.mkEnableOption "custom steam config";
  config = lib.mkIf config.custom.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraPackages = with pkgs; [
        libgudev
        libvdpau
        libsoup_2_4
        libusb1
        speex
        SDL2
        openal
        libglvnd
        gtk3
        mono
        dbus
        nur.repos.nukdokplex.FAE_Linux
      ];

      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    programs.gamescope = {
      enable = true;
    };
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-cpp;
      extraRules = [
        {
          "name" = "gamescope";
          "nice" = -20;
        }
      ];
    };
  };
}
