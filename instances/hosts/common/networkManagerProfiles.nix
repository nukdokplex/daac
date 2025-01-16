{ config, ... }: {
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.age.secrets.networkmanager_environment.path
    ];

    profiles = {
      # use this neat program to generate profiles:
      # https://github.com/Janik-Haag/nm2nix
      yggdrasils-wifi4 = {
        connection = {
          id = "yggdrasils-wifi4";
          type = "wifi";
        };
        ipv4.method = "auto";
        ipv6.method = "auto";
        proxy = { };
        wifi = {
          mode = "infrastructure";
          ssid = "yggdrasils_4";
          mtu = 1476;
        };
        wifi-security = {
          key-mgmt = "sae";
          psk = "$yggdrasils_wifi_secret";
        };
      };
      yggdrasils-wifi5 = {
        connection = {
          id = "yggdrasils-wifi5";
          type = "wifi";
        };
        ipv4.method = "auto";
        ipv6.method = "auto";
        proxy = { };
        wifi = {
          mode = "infrastructure";
          ssid = "yggdrasils_5";
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
        ipv6.method = "auto";
        proxy = { };
        ethernet = {
          mtu = 1476;
        };
      };
    };
  };
}
