{ lib, config, ... }: {
  services.sing-box = {
    enable = false;
    settings = {
      dns = {
        servers = [
          {
            tag = "dns-remote";
            address = "https://rix01.dnscry.pt/dns-query";
            address_resolver = "dns-default";
            address_strategy = "ipv4_only";
            detour = "direct-out";
          }
          {
            tag = "dns-default";
            address = "local";
            detour = "direct-out";
          }
          {
            tag = "dns-block";
            address = "rcode://refused";
          }
        ];
        final = "dns-remote";
      };
      inbounds = [
        {
          type = "tun";
          tag = "tun-in";
          mtu = 1400;
          address = "172.16.0.1/30";
          auto_route = true;
          strict_route = true;
          route_address = [
            "0.0.0.0/1"
            "128.0.0.0/1"
          ];
          route_exclude_address = [
            "10.0.0.0/8"
            "172.16.0.0/12"
            "192.168.0.0/16"
            "fc00::/7"
          ];
          stack = "system";
          sniff = true;
        }
      ];
      outbounds = [
        {
          type = "vless";
          tag = "vless-out";
          domain_strategy = "ipv4_only";
          server = { _secret = config.age.secrets.sing-box-vless-out-ip.path; };
          server_port = 443;
          uuid = { _secret = config.age.secrets.sing-box-vless-out-uuid.path; };
          flow = "xtls-rprx-vision";
          tls = {
            enabled = true;
            server_name = "creativecloud.adobe.com";
            alpn = "h2";
            utls = {
              enabled = true;
              fingerprint = "firefox";
            };
            reality = {
              enabled = true;
              public_key = { _secret = config.age.secrets.sing-box-vless-out-public_key.path; };
              short_id = { _secret = config.age.secrets.sing-box-vless-out-short_id.path; };
            };
          };
          multiplex.enabled = false;
          packet_encoding = "xudp";
        }
        {
          type = "direct";
          tag = "direct-out";
        }
        {
          type = "dns";
          tag = "dns-out";
        }
        {
          type = "block";
          tag = "block-out";
        }
      ];
      route = {
        rules = [
          {
            protocol = "dns";
            outbound = "dns-out";
          }
          {
            ip_is_private = true;
            outbound = "direct-out";
          }
        ];
        final = "vless-out";
        auto_detect_interface = true;
      };
    };
  };
}
