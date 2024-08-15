{ ... }: {
  imports = [
    ./users.nix
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
}