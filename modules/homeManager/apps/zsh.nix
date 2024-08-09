{ lib, pkgs, config, ... }: lib.cor.mkHomeManagerAppModule {
  inherit config;
  name = "zsh";
  enableDefault = true;
  moduleCfg = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      shellAliases = {
        # "ll" = "ls -l";
        # "nrb" = "sudo nixos-rebuild boot --flake path:${config.home.homeDirectory}/nixos-daac/#${osConfig.networking.hostName}";
        # "nrs" = "sudo nixos-rebuild switch --flake path:${config.home.homeDirectory}/nixos-daac/#${osConfig.networking.hostName}";
      };

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" "sudo" "systemd" ];
      };
    };
  };
}
