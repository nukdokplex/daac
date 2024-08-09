{ self
, lib
, pkgs
}:
let
  inherit (lib) cor;
in
{
  mkEnableOption = default: description: lib.mkOption {
    inherit default description;
    example = ! default;
    type = lib.types.bool;
  };

  mkPrivilegedUsersOption = description: lib.mkOption {
    inherit description;
    default = [ ];
    example = [ "user1" ];
    type = lib.types.listOf lib.types.nonEmptyStr;
  };

  mkCorModule =
    { domain
    , category
    , name
    , config
    , enableDefault ? false
    , privilegedUsersGroup ? ""
    , moduleCfg
    }:
    let
      cfg = config.cor.${domain}.${category}.${name};
    in
    {
      options.cor.${domain}.${category}.${name} = {
        enable = cor.mkEnableOption
          enableDefault
          "Whether to enable ${name} ${category} managed configuration for ${name}."
        ;
      } // (
        if lib.types.nonEmptyStr.check privilegedUsersGroup
        then {
          privilegedUsers = cor.mkPrivilegedUsersOption
            "Users who have access to resources opened with ${domain} ${category} for ${name}."
          ;
        } else { }
      );

      config = lib.mkIf cfg.enable { }
        // moduleCfg
        // (
        if (lib.types.nonEmptyStr.check privilegedUsersGroup)
        then {
          users.extraGroups.${privilegedUsersGroup}.members = cfg.privilegedUsers;
        }
        else { }
      );
    };

  mkHomeManagerAppModule =
    { name
    , config
    , enableDefault ? false
    , moduleCfg ? { }
    }:
    let
      cfg = config.cor.home.apps.${name};
    in
    {
      options.cor.home.apps.${name} = {
        enable = cor.mkEnableOption
          enableDefault
          "Whether to enable ${name} app in current Home Manager configuration."
        ;
      };

      config = lib.mkIf cfg.enable moduleCfg;
    };
}
