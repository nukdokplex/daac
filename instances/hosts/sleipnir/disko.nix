{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/eui.00253857019d3107";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                content = {
                  type = "lvm_pv";
                  vg = "main_pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      main_pool = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "36G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}