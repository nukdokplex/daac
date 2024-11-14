{ self, ... }: {
  config = {
    users.users.nukdokplex = {
      isNormalUser = true;
      description = "NukDokPlex";
      hashedPassword = "$y$j9T$/M4npJEjUk8hut8Hy6n4G0$SOrbq5x.G/LTdeFjM7h6DvpvxX7DtsQ.XeUBuR.p7E7";
      extraGroups = [
        "wheel"
        "input"
        "gamemode"
        "networkmanager"
        "docker"
        "vboxusers"
        "adbusers"
        "cdrom"
      ];
    };

    nix.settings.trusted-users = [ "nukdokplex" ];

    home-manager.users.nukdokplex = self.instances.homes.nukdokplex;
  };
}
