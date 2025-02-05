{ config, ... }: {
  age.secrets = {
    yggdrasil = {
      file = ./yggdrasil.age;
      mode = "400";
      owner = "root";
      group = "root";
    };
    sb-vless-server = {
      file = ./sb-vless-server.age;
      mode = "400";
      owner = "root";
      group = "root";
    };
    sb-vless-uuid = {
      file = ./sb-vless-uuid.age;
      mode = "400";
      owner = "root";
      group = "root";
    };
    sb-vless-public_key = {
      file = ./sb-vless-public_key.age;
      mode = "400";
      owner = "root";
      group = "root";
    };
    sb-vless-short_id = {
      file = ./sb-vless-short_id.age;
      mode = "400";
      owner = "root";
      group = "root";
    };
  };

  services.yggdrasil.configFile = config.age.secrets.yggdrasil.path;
}
