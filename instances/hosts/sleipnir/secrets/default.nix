{ config, ... }: {
  age.secrets = {
    yggdrasil = {
      file = ./yggdrasil.age;
      mode = "400";
      owner = "root";
      group = "root";
    };
  };

  services.yggdrasil.configFile = config.age.secrets.yggdrasil.path;
}
