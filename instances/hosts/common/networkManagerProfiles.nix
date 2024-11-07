{ config, ... }: {
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.age.secrets.networkmanager_environment.path
    ];

    profiles = {
      # use this neat program to generate profiles:
      # https://github.com/Janik-Haag/nm2nix
      yggdrasils-wifi = {
        connection = {
          id = "yggdrasils-wifi";
          type = "wifi";
        };
        ipv4.method = "auto";
        ipv6.method = "disabled";
        proxy = { };
        wifi = {
          mode = "infrastructure";
          ssid = "yggdrasils";
          mtu = 1476;
        };
        wifi-security = {
          key-mgmt = "sae";
          psk = "$yggdrasils_wifi_secret";
        };
      };
      yggdrasils-eth = {
        connection = {
          id = "yggdrasils-eth";
          type = "ethernet";
        };
        ipv4.method = "auto";
        ipv6.method = "disabled";
        proxy = { };
        ethernet = {
          mtu = 1476;
        };
      };
    };
  };
}
