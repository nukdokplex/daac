{ self
, pkgs
, ...
}:
let
  system = "x86_64-linux";
in
{
  imports = [
    ../common
    # ./disko.nix
    self.inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nixpkgs.hostPlatform = system;
  networking.hostName = "sleipnir-vm";
  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "ru_RU.UTF-8";
  system.stateVersion = "24.05";

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192; # Use 2048MiB memory.
      cores = 3;
    };
  };

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
  services.greetd.enable = true;

  services.greetd.settings = {
    initial_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = "nukdokplex";
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
      # wayland.windowManager.hyprland.settings.monitor = [
      #   "desc:LG Electronics LG ULTRAWIDE 0x00000459, 2560x1080@60.00000, 0x0, 1.00"
      # ];
      custom.usesBattery = false;
    }
  ];

  services.printing.drivers = [
    self.inputs.nukdokplex-nix-repository.packages.${system}.epson_201310w
  ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_L120_Series";
        location = "Home";
        deviceUri = "usb://EPSON/L120%20Series?serial=544E594B3132383744";
        model = "EPSON_L120.ppd";
      }
    ];
  };

  # systemd.mounts = [
  #   {
  #     name = "data-archive.mount";
  #     enable = true;
  #     wantedBy = [ "multi-user.target" ];
  #     what = "/dev/disk/by-label/ARCHIVE";
  #     where = "/data/archive";
  #     type = "ext4";
  #     options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
  #   }
  #   {
  #     name = "data-downloads.mount";
  #     enable = true;
  #     wantedBy = [ "multi-user.target" ];
  #     what = "/dev/disk/by-label/DOWNLOADS";
  #     where = "/data/downloads";
  #     type = "ext4";
  #     options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
  #   }
  #   {
  #     name = "data-fastext.mount";
  #     enable = true;
  #     wantedBy = [ "multi-user.target" ];
  #     what = "/dev/disk/by-label/FASTEXT";
  #     where = "/data/fastext";
  #     type = "ext4";
  #     options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
  #   }
  #   {
  #     name = "data-passport.mount";
  #     enable = true;
  #     wantedBy = [ "multi-user.target" ];
  #     what = "/dev/mapper/passport";
  #     where = "/data/passport";
  #     type = "ext4";
  #     options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
  #   }
  # ];

  programs.steam.enable = true;

  services.pipewire.extraConfig.pipewire."99-latency-settings" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.force-quantum" = 256;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 8192;
    };
  };

  # services.pipewire.extraConfig.pipewire-pulse."99-latency-settings" = {
  #   context.modules = [
  #     {
  #       name = "libpipewire-module-protocol-pulse";
  #       args = {
  #         pulse.min.req = "1024/48000";
  #         pulse.default.req = "1024/48000";
  #         pulse.max.req = "1024/48000";
  #         pulse.min.quantum = "1024/48000";
  #         pulse.max.quantum = "1024/48000";
  #       };
  #     }
  #   ];
  #   stream.properties = {
  #     node.latency = "1024/48000";
  #     resample.quality = 1;
  #   };
  # };

  # environment.etc.crypttab.text = ''
  #   passport /dev/disk/by-label/PASSPORT none
  # '';
}
