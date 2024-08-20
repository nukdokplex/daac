{ config, lib, ... }: {
  programs.zsh = {
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