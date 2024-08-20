{ config, lib, pkgs, ... }: {
  programs.zsh.enable = lib.mkDefault true;
  users.defaultUserShell = pkgs.zsh;
}
