{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme_SSD_970_EVO_Plus_500GB_S4EVNZFN703254E";
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