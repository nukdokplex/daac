{config, ...}: {
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.age.secrets.wifi_passwords.path
    ];

    profiles = {
      ndp-home-2 = {
        connection = {
          id = "ndp-home-2";
          type = "wifi";
        };

        wifi = {
          ssid = "ndp-home-2";
          mode = "infrastructure";
        };

        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$YGGDRASILS_PSK";
        };
        ipv4.method = "auto";
        ipv6.method = "disabled";
      };
      ndp-home-5 = {
        connection = {
          id = "ndp-home-5";
          type = "wifi";
        };

        wifi = {
          ssid = "ndp-home-5";
          mode = "infrastructure";
        };

        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$YGGDRASILS_PSK";
        };
        ipv4.method = "auto";
        ipv6.method = "disabled";
      };
    };
  };
}
