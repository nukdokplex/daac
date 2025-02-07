{ config, lib, ... }:
let
  tunName = "tun-singbox";
in
{
  networking.firewall.trustedInterfaces = [ tunName ];
  systemd.services.sing-box.wantedBy = lib.mkForce [ ];
  services.sing-box = {
    enable = false;
    settings = {
      log = {
        level = "debug";
      };
      dns = {
        servers = [
          {
            tag = "local";
            address = "local";
          }
          {
            tag = "google";
            address = "tcp://8.8.8.8:53";
            detour = "vless-out";
          }
          {
            tag = "cloudflare-dot";
            address = "tls://one.one.one.one:853";
            address_resolver = "local";
          }
        ];
        final = "google";
        strategy = "prefer_ipv6";
        independent_cache = true;
      };
      ntp = {
        enabled = true;
        server = "ru.pool.ntp.org";
        server_port = 123;
        interval = "30m";
      };
      inbounds = [
        {
          tag = "tun-in";
          type = "tun";
          interface_name = tunName;
          address = [
            "172.16.0.1/30"
            "fd00::1/126"
          ];
          route_address = [
            "0.0.0.0/1"
            "128.0.0.0/1"
            "::/1"
            "8000::/1"
          ];
          route_exclude_address = [
            "fc00::/7"
            "200::/7"
          ];
          mtu = 1480;
          auto_route = true;
          auto_redirect = true;
          strict_route = true;
          sniff = true;
          stack = "system";
        }
      ];
      outbounds = [
        {
          tag = "vless-out";
          type = "vless";
          server = { _secret = config.age.secrets.sb-vless-server.path; };
          server_port = 44433;
          uuid = { _secret = config.age.secrets.sb-vless-uuid.path; };
          flow = "xtls-rprx-vision";
          tls = {
            enabled = true;
            server_name = "creativecloud.adobe.com";
            utls = {
              enabled = true;
              fingerprint = "firefox";
            };
            reality = {
              enabled = true;
              public_key = { _secret = config.age.secrets.sb-vless-public_key.path; };
              short_id = { _secret = config.age.secrets.sb-vless-short_id.path; };
            };
          };
        }
        {
          tag = "direct-out";
          type = "direct";
        }
        {
          tag = "dns-out";
          type = "dns";
        }
        {
          tag = "block-out";
          type = "block";
        }
      ];
      route = {
        auto_detect_interface = true;
        final = "direct-out";
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
      };
    };
  };
}



