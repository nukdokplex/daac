{ pkgs, lib, ... }: {
  age.secrets = {
    sing-box-vless-out-short_id = {
      file = ./sing-box/vless-out-short_id.age;
      path = "/etc/sing-box/secrets/vless-out/short_id";
      mode = "400";
      owner = "root";
      group = "root";
    };
    sing-box-vless-out-uuid = {
      file = ./sing-box/vless-out-uuid.age;
      path = "/etc/sing-box/secrets/vless-out/uuid";
      mode = "400";
      owner = "root";
      group = "root";
    };
  };
}
