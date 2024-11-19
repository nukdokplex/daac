{ self, pkgs, config, ... }: {
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
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    package = self.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = self.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.greetd.enable = true;

  services.greetd.settings = {
    initial_session = {
      command = "${config.programs.hyprlans.package}/bin/Hyprland";
      user = "nukdokplex";
    };
  };

  networking.networkmanager.ensureProfiles.profiles = {
    yggdrasils-wifi.wifi.mac-address = "$gladr_wifi_mac";
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
      custom.usesBattery = true;
    }
  ];
}
