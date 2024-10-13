{osConfig, ...}:{
  programs.zsh = {
    enable = true;

    shellAliases = {
      nrt = "nixos-rebuild test --flake path:$HOME/daac#${osConfig.networking.hostName}";
      nrb = "nixos-rebuild boot --flake path:$HOME/daac#sleipnir";
      nrs = "nixos-rebuild switch --flake path:$HOME/daac#sleipnir";
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
