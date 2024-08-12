{ ... }: {
  imports = [
    ./users.nix
  ];

  cor.nixos.services.ssh.enable = true;
}