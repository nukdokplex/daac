{ pkgs, ... }: {
  programs.steam = {
    extraPackages = with pkgs; [
      gamescope
      gamemode
      mangohud
    ];

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
