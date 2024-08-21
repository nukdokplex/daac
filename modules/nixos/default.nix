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
    ./nix.nix
    ./packages.nix
    ./stylix.nix
  ];
}
