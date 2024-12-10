{ self
, config
, pkgs
, ...
}:
let
  agenix = self.inputs.agenix.packages.${config.nixpkgs.hostPlatform.system}.agenix;
  alejandra = self.inputs.alejandra.defaultPackage.${config.nixpkgs.hostPlatform.system};
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
    reiser4progs
    reiserfsprogs
    xfsprogs
    zfs

    # optical disks
    udftools
    cdrtools
    cdrdao
    cdrkit
    dvdplusrwtools

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
  ];

  # fix cdrdao and cdrecord doesn't have permission to cd rom
  # that fixes issues with programs such as k3b also
  security.wrappers = {
    cdrdao = {
      setuid = true;
      owner = "root";
      group = "cdrom";
      permissions = "u+wrx,g+x";
      source = "${pkgs.cdrdao}/bin/cdrdao";
    };
    cdrecord = {
      setuid = true;
      owner = "root";
      group = "cdrom";
      permissions = "u+wrx,g+x";
      source = "${pkgs.cdrtools}/bin/cdrecord";
    };
  };
}
