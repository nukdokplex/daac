{
  self,
  lib,
  ...
}: {
  imports = [
    ../common
    ./disko.nix
    self.inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "ndp-desktop";
  time.timeZone = "Asia/Yekaterinburg";
  system.stateVersion = "24.05";

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
      kernelModules = [];
      systemd.enable = true;
    };

    kernelModules = ["kvm-amd"];
    extraModulePackages = [];

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = lib.mkForce false;
      systemd-boot.consoleMode = "max";
    };
  };
}
