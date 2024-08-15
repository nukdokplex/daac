{ self, config, ... }: {
  config = {
    # TODO dehardcodify users
    users.users.nukdokplex = {
      isNormalUser = true;
      description = "NukDokPlex";
      hashedPassword = "$y$j9T$/M4npJEjUk8hut8Hy6n4G0$SOrbq5x.G/LTdeFjM7h6DvpvxX7DtsQ.XeUBuR.p7E7";
    };

    home-manager.users.nukdokplex = self.instances.homes.nukdokplex;

    cor.nixos.hardware.libinput.enable = true;

    # add user to privileged groups if exist
    cor.nixos.hardware.libinput.privilegedUsers = [ "nukdokplex" ];
    cor.nixos.misc.gamemode.privilegedUsers = [ "nukdokplex" ];
    cor.nixos.misc.sudo.privilegedUsers = [ "nukdokplex" ];
    cor.nixos.networking.networkmanager.privilegedUsers = [ "nukdokplex" ];
    cor.nixos.virtualisation.docker.privilegedUsers = [ "nukdokplex" ];
    cor.nixos.virtualisation.virtualbox.privilegedUsers = [ "nukdokplex" ];
  };
}
