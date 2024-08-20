{ ... }: {
  imports = [
    ./hardware
    ./networking
    ./programs
    ./security
    ./services
    ./virtualisation
    ./console.nix
    ./fonts.nix
    ./packages.nix
    ./stylix.nix
  ];
}
