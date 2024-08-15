{ ... }: {
  imports = [
    ./users.nix
  ];

  hardware.enableRedistributableFirmware = true;
}