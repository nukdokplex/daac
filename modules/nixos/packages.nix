{ config, lib, pkgs, ... }: {
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
  ];
}
