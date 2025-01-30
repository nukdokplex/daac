{ pkgs, config, lib, ... }: {
  options.custom.steam.enable = lib.mkEnableOption "custom steam config";
  config = lib.mkIf config.custom.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraPackages = with pkgs; [
        gamemode
        mangohud
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
      ];

      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
