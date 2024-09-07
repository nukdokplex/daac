{lib, ...}: {
  options.idling-settings = {
    lockSessionTimeout = lib.mkOption {
      default = -1;
      type = lib.types.int;
    };

    screenOffTimeout = lib.mkOption {
      default = -1;
      type = lib.types.int;
    };

    suspendTimeout = lib.mkOption {
      default = -1;
      type = lib.types.int;
    };
  };
}
