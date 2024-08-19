{ config, lib, ... }: {
  services.pipewire = lib.mkDefault {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
}
