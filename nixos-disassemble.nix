{ lib, ... }: {
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_L120_Series";
        location = "Home";
        deviceUri = "usb://EPSON/L120%20Series?serial=544E594B3132383744";
        model = "EPSON_L120.ppd";
      }
    ];
  };

   systemd.mounts = [
    {
      name = "data-archive.mount";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      what = "/dev/disk/by-uuid/81534a78-20f8-4d78-8f5f-2134406cc300";
      where = "/data/archive";
      type = "ext4";
      options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
    }
    {
      name = "data-downloads.mount";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      what = "/dev/disk/by-uuid/87fadf5b-bd21-4f97-8a39-57b6632fd9d0";
      where = "/data/downloads";
      type = "ext4";
      options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
    }
    {
      name = "data-virtual.mount";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      what = "/dev/disk/by-uuid/efcf86fd-a475-4957-a99f-81946caf808d";
      where = "/data/virtual";
      type = "ext4";
      options = "rw,nosuid,nodev,noatime,errors=remount-ro,x-mount.mkdir=0755";
    }
    {
      name = "data-passport.mount";
      enable = true;
      wantedBy = [ "multi-user.target" ];
      what = "/dev/mapper/passport";
      where = "/data/passport";
      type = "ext4";
      options = "rw,nosuid,nodev,relatime,errors=remount-ro,x-mount.mkdir=0755";
    }
  ];

  environment.etc."crypttab".text = ''
    passport /dev/disk/by-label/PASSPORT none tpm2-device=auto,tpm2-pcrs=0+2+7+12
  '';
}