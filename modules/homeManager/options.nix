{ lib, ... }: {
  options = {
    custom.usesBattery = lib.mkEnableOption "battery";
  };
}
