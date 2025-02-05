{ self, pkgs, config, lib, ... }:
{
  imports = [
    ../common
    ./disko.nix
    ./secrets
    ./sing-box.nix
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
        command = "'${lib.getExe pkgs.greetd.tuigreet}' --time --user-menu --user-menu-min-uid 1000 --cmd '${lib.getExe config.programs.hyprland.package}'";
        user = "greeter";
      };
      # initial_session = {
      #  command = "'${lib.getExe config.programs.hyprland.package}'";
      #  user = "nukdokplex";
      # };
    };
  };
  services.hardware.openrgb.enable = true;

  environment.etc.secureboot-GUID = {
    source = ./GUID;
    target = "secureboot/GUID";
    mode = "0400";
    user = "root";
    group = "root";
  };

  programs.hyprland.enable = true;
  security.pam.services.hyprlock = { };

  home-manager.sharedModules = [
    {
      custom.hyprland.enable = true;
      custom.hypridle.timeouts = {
        off_backlight = 300;
        lock = 360;
        suspend = 3600;
      };

      wayland.windowManager.hyprland.settings.monitor = [
        "desc:LG Electronics LG ULTRAWIDE 0x00000459, 2560x1080@60.00000, 0x0, 1.00"
      ];
      wayland.windowManager.sway = {
        config = {
          startup = lib.mkAfter [
            { command = "'${lib.getExe' pkgs.sway "swaymsg"}' create_output"; }
          ];
          output = {
            "LG Electronics LG ULTRAWIDE 0x00000459" = {
              mode = "2560x1080@60Hz";
              scale = "1.0";
              pos = "1920 0";
            };
            "HEADLESS-1" = {
              res = "1920x1080";
              scale = "1.0";
              pos = "0 0";
            };
          };
          workspaceOutputAssign = [
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "1"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "2"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "3"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "4"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "5"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "6"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "7"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "8"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "9"; }
            { output = "LG Electronics LG ULTRAWIDE 0x00000459"; workspace = "10"; }
            { output = "HEADLESS-1"; workspace = "11"; }
            { output = "HEADLESS-1"; workspace = "12"; }
            { output = "HEADLESS-1"; workspace = "13"; }
            { output = "HEADLESS-1"; workspace = "14"; }
            { output = "HEADLESS-1"; workspace = "15"; }
            { output = "HEADLESS-1"; workspace = "16"; }
            { output = "HEADLESS-1"; workspace = "17"; }
            { output = "HEADLESS-1"; workspace = "18"; }
            { output = "HEADLESS-1"; workspace = "19"; }
            { output = "HEADLESS-1"; workspace = "20"; }
          ];
        };
      };
      custom.usesBattery = false;
    }
  ];

  services.printing.drivers = [
    pkgs.nur.repos.nukdokplex.epson_201310w
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

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  networking.networkmanager.ensureProfiles.profiles = {
    yggdrasils-wifi4.connection.autoconnect = "false";
    yggdrasils-wifi5.connection.autoconnect = "false";
    yggdrasils-eth.ethernet.mac-address = "$sleipnir_25geth_mac";
  };

  networking.interfaces.enp42s0.wakeOnLan.enable = true;

  systemd.mounts = [
    {
      name = "data-archive.mount";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      what = "/dev/disk/by-label/ARCHIVE";
      where = "/data/archive";
      type = "ext4";
      options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
    }
    {
      name = "data-downloads.mount";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      what = "/dev/disk/by-label/DOWNLOADS";
      where = "/data/downloads";
      type = "ext4";
      options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
    }
    {
      name = "data-fastext.mount";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      what = "/dev/disk/by-label/FASTEXT";
      where = "/data/fastext";
      type = "ext4";
      options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
    }
  ];

  custom.steam.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
