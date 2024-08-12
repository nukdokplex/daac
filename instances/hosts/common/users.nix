{ self, ... }: {
  config = {
    # TODO dehardcodify users
    users.users.nukdokplex = {
      isNormalUser = true;
      description = "NukDokPlex";
      hashedPasswordFile = config.age.secrets.nukdokplexPasswordFile.path;
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
