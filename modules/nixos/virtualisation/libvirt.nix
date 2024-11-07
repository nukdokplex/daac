{ pkgs, ... }: {
  virtualisation.libvirtd = {
    qemu = {
      runAsRoot = true;
    };
  };
}
