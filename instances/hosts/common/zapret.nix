{ lib, ... }:
{
  services.zapret = lib.mkDefault {
    enable = true;
    params = [
      "--dpi-desync=fake,disorder2"
      "--dpi-desync-ttl=1"
      "--dpi-desync-autottl=2"
    ];
    whitelist = [
      "youtube.com"
      "googlevide.com"
      "ytimg.com"
      "youtu.be"
      "cache.nixos.org"
      "home-manager-options.extranix.com"
    ];
    configureFirewall = true;
  };
}
