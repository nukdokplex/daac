{ ... }: {
  age.secrets = {
    # secureboot stuff
    sb_db_pem = {
      file = ./secureboot/db/db.pem.age;
      path = "/etc/secureboot/keys/db/db.pem";
      mode = "400";
      owner = "root";
      group = "root";
    };
    sb_db_key = {
      file = ./secureboot/db/db.key.age;
      path = "/etc/secureboot/keys/db/db.key";
      mode = "400";
      owner = "root";
      group = "root";
    };

    sb_KEK_pem = {
      file = ./secureboot/KEK/KEK.pem.age;
      path = "/etc/secureboot/keys/KEK/KEK.pem";
      mode = "400";
      owner = "root";
      group = "root";
    };
    sb_KEK_key = {
      file = ./secureboot/KEK/KEK.key.age;
      path = "/etc/secureboot/keys/KEK/KEK.key";
      mode = "400";
      owner = "root";
      group = "root";
    };

    sb_PK_pem = {
      file = ./secureboot/PK/PK.pem.age;
      path = "/etc/secureboot/keys/PK/PK.pem";
      mode = "400";
      owner = "root";
      group = "root";
    };
    sb_PK_key = {
      file = ./secureboot/PK/PK.key.age;
      path = "/etc/secureboot/keys/PK/PK.key";
      mode = "400";
      owner = "root";
      group = "root";
    };

    wifi_passwords.file = ./wifi_passwords.age;
  };
}