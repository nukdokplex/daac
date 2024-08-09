{ self
, config
, lib
, pkgs
, ...
}: {
  imports = import ../lib/import-modules.nix {
    inherit self config lib pkgs;
    modules = [ ]
      ++ import ./apps
      ++ import ./desktop
    ;
  };
}
