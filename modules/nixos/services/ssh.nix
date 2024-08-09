{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "services";
  name = "ssh";
  enableDefault = false;
  moduleCfg = {
    services.openssh = {
      enable = true;

      allowSFTP = true;
      authorizedKeysInHomedir = true;
      ports = [ 33727 ];
      openFirewall = true;

      settings = {
        PrintMotd = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        AllowGroups = [ "users" ];
      };
    };
  };
}
