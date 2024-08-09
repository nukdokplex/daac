{ config, lib, pkgs, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "misc";
  name = "zsh";
  enableDefault = false;
  moduleCfg = {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
