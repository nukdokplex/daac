{ lib, config, ... }: {
  programs.git = lib.mkDefault {
    enable = true;
  };
}