{ config, lib, pkgs, ... }: {
  programs.zsh.enable = lib.mkDefault true;
  users.defaultUserShell = lib.mkDefault pkgs.zsh;
}
