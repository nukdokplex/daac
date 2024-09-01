{ self, lib, config, ... }: {
  imports = [
    ../common
    ./disko.nix
    self.inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "gladr";
  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "ru_RU.UTF-8";
  system.stateVersion = "24.05";

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ "amdgpu" ];
      systemd.enable = true;
    };

    kernelModules = [ "kvm-amd" "amdgpu" ];
    extraModulePackages = [ ];

    lanzaboote = {
      enable = true;
      enrollKeys = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  environment.etc.secureboot-GUID = {
    source = ./GUID;
    target = "secureboot/GUID";
    mode = "0400";
    user = "root";
    group = "root";
  };

  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings.monitor = [
        "desc:LG Display 0x05F6, 1920x1080, 0x0, 1.25"
      ];
      custom.usesBattery = true;
    }
  ];

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