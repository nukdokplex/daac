{ self, lib, config, ... }: {
  imports = [
    ../common
    ./disko.nix
    self.inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "sleipnir";
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
        "desc:LG Electronics LG ULTRAWIDE 0x00000459, 2560x1080@60.00000, 0x0, 1.00"
      ];
      custom.usesBattery = false;
    }
  ];
}