{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_500GB_S4EVNZFN703254E";
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
            ssh = {
              size = "512M";
              content = {
                type = "luks";
                name = "ssh";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/etc/ssh";
                };
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            swap = {
              size = "36GB";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };      
          };
        };
      };
    };
  };
}