{ lib, pkgs, ... }: lib.cor.mkCorModule {
  domain = "nixos";
  category = "desktop";
  name = "sddm";
  enableDefault = false;
  moduleCfg = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      package = pkgs.kdePackages.sddm;
    };
  };
}
