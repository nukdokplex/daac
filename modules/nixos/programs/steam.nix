{ pkgs, ... }: {
  programs.steam = {
    extraPackages = with pkgs; [
      gamescope
      gamemode
      mangohud
      libgudev
      libvdpau
      libsoup_2_4
      libusb1
      speex
    ];

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
