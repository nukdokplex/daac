{ self, pkgs, config, lib, ... }: {
  imports = [
    ../common
    ./disko.nix
    ./secrets
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
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "'${lib.getExe pkgs.greetd.tuigreet}' --cmd '${lib.getExe pkgs.sway}' --time --user-menu --user-menu-min-uid 1000";
        user = "greeter";
      };
      initial_session = {
        command = "'${lib.getExe pkgs.sway}'";
        user = "nukdokplex";
      };
    };
  };


  networking.networkmanager.ensureProfiles.profiles = {
    yggdrasils-wifi4.wifi.mac-address = "$gladr_wifi_mac";
    yggdrasils-wifi5.wifi.mac-address = "$gladr_wifi_mac";
    yggdrasils-eth.ethernet.mac-address = "$tplink_ue200_mac";
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
      wayland.windowManager.sway.config = {
        output."LG Display 0x05F6 Unknown" = {
          scale = "1.25";
        };
        input."1739:52545:SYN1B7F:00_06CB:CD41_Touchpad" = {
          natural_scroll = "enabled";
          dwt = "enabled";
          tap = "enabled";
          drag_lock = "enabled";
          click_method = "button_areas";
        };
      };
      custom.usesBattery = true;
      wayland.windowManager.sway.enable = true;
    }
  ];
}
