{ config, lib, ... }: {
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
}
