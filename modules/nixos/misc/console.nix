{ config, lib, pkgs, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "misc";
  name = "console";
  enableDefault = true;
  moduleCfg = {
    console = {
      enable = true;
      earlySetup = true;
      font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v32n.psf.gz";
      packages = with pkgs; [ powerline-fonts ];
      keyMap = "ru";
    };
  };
}
