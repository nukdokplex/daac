{ pkgs, lib, config, ... }:
let
  cfg = config.programs.via;
in
{
  options.programs.via = {
    enable = lib.mkEnableOption "Via keyboard configurator";
    package = lib.mkPackageOption pkgs "via" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    services.udev.packages = [ cfg.package ];
  };
}
