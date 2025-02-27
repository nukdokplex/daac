{ self, pkgs, lib, ... }:
let
  agenix = self.inputs.agenix.packages.${pkgs.system}.agenix;
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
  ];

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
    reiserfsprogs
    xfsprogs
    zfs
    ventoy-full

    # optical disks
    udftools
    cdrtools
    cdrdao
    cdrkit
    dvdplusrwtools
    kdePackages.k3b

    # usb
    usbutils
    usb-modeswitch
    usb-modeswitch-data

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
    tmux
    cmatrix
    kittysay
    ponysay
    fastfetch
    sl # steam locomotive
    inotify-tools
    psmisc
    nixpkgs-fmt
    nix-search-cli
    agenix
    btop
    atop
    nmap
    htop
    jq # cli util to work with json
    libwebp
    bind # dns tools like dig, nslookup, etc
    pwvucontrol
    (python312.withPackages (ps: [ ps.gspread ps.openpyxl ]))
    python2
    wget
    vim
    nix-index
    cachix
    ffmpeg
    qmk
    w3m
    tigervnc
  ];

  security.wrappers = {
    cdrdao = {
      setuid = true;
      owner = "root";
      group = "cdrom";
      permissions = "u+wrx,g+x";
      source = lib.getExe' pkgs.cdrdao "cdrdao";
    };
    cdrecord = {
      setuid = true;
      owner = "root";
      group = "cdrom";
      permissions = "u+wrx,g+x";
      source = lib.getExe' pkgs.cdrtools "cdrecord";
    };
  };
}
