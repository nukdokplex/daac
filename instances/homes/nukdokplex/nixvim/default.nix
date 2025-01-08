{ pkgs, lib, ... }: {
  imports = [
    ./plugins
    ./keymappings.nix
  ];
}
