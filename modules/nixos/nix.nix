{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  home-manager.backupFileExtension = "hm-bak";
}
