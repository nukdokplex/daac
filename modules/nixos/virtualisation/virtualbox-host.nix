{ config, lib, ... }: {
  virtualisation.virtualbox.host = lib.mkDefault {
    enable = true;
    enableExtensionPack = true;
  };
}
