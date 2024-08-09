{ self
, modules
, config
, lib
, pkgs
}:
let
  toModule = file: {
    _file = file;
    imports = [
      (import file {
        inherit self config pkgs;
        lib = lib.extend (
          final: _: {
            cor = import ./. {
              inherit self pkgs;
              lib = final;
            };
          }
        );
      })
    ];
  };
in
map toModule modules
