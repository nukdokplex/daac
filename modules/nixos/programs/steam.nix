{ pkgs, ... }: {
  programs.steam = {
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
}
