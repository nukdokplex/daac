{ osConfig, ... }: {
  programs.zsh = {
    enable = true;

    shellAliases = {
      nrt = "sudo nixos-rebuild test --flake path:$HOME/daac#${osConfig.networking.hostName}";
      nrb = "sudo nixos-rebuild boot --flake path:$HOME/daac#${osConfig.networking.hostName}";
      nrs = "sudo nixos-rebuild switch --flake path:$HOME/daac#${osConfig.networking.hostName}";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "sudo"
        "systemd"
        "docker"
        "ssh"
      ];
    };
  };
}
