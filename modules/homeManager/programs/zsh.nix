{ config, lib, ... }: {
  programs.zsh = lib.mkDefault {
    enable = true;
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