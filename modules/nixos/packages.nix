{
  self,
  config,
  pkgs,
  ...
}: let
  agenix = self.inputs.agenix.packages.${config.nixpkgs.hostPlatform.system}.agenix;
  alejandra = self.inputs.alejandra.defaultPackage.${config.nixpkgs.hostPlatform.system};
in {
  environment.systemPackages = with pkgs; [
    # file systems
    apfsprogs
    btrfs-progs
    cryptsetup
    dosfstools
    e2fsprogs
    exfatprogs
    f2fs-tools
    hfsprogs
    ntfs3g
    reiser4progs
    reiserfsprogs
    udftools
    xfsprogs
    zfs

    # archives
    zip
    unzip
    rar
    unrar
    gnutar
    gzip

    # android
    # android-tools moved to config.programs.adb
    scrcpy

    # misc
    cmatrix
    kittysay
    ponysay
    fastfetch
    sl # steam locomotive
    inotify-tools
    psmisc
    nixpkgs-fmt
    alejandra
    nix-search-cli
    agenix
    btop
    htop
    jq # cli util to work with json
    bind # dns tools like dig, nslookup, etc
  ];
}
