{ self
, config
, lib
, pkgs
, ...
}: {
  imports = import ../lib/import-modules.nix {
    inherit self config lib pkgs;
    modules = [ ]
      ++ import ./desktop
      ++ import ./hardware
      ++ import ./misc
      ++ import ./networking
      ++ import ./packages
      ++ import ./services
      ++ import ./virtualisation
    ;
  };
}
