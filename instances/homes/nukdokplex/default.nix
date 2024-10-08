{
  self,
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  username = "nukdokplex";
in {
  imports = [
    self.modules.homeManager.default
    self.inputs.agenix.homeManagerModules.age
    ./secrets
    ./mail.nix
  ];

  home = {
    stateVersion = "24.05"; # TODO: dehardcodify
    homeDirectory = "/home/${username}";
    inherit username;

    packages = with pkgs; [
      vesktop
      _64gram
      keepassxc
      qbittorrent
      vlc
      libreoffice-fresh
      tor-browser
      self.inputs.nukdokplex-nix-repository.packages.${osConfig.nixpkgs.hostPlatform.system}.KToolBox
    ];
  };

  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/download";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    publicShare = "${config.home.homeDirectory}/public_share";
    templates = "${config.home.homeDirectory}/templates";
    videos = "${config.home.homeDirectory}/videos";
  };

  programs = {
    git = {
      userName = "nukdokplex";
      userEmail = "nukdokplex@nukdokplex.ru";
    };
    pcmanfm.enable = true;
    waybar.enable = true;
    thunderbird.enable = true;
  };

  services.syncthing.enable = true;

  custom.gaming.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    # TODO: these packages are hardcoded

    settings = {
      bind = [
        "$mainMod, W, exec, ${lib.getExe pkgs.firefox}"
        "$mainMod, Q, exec, ${lib.getExe pkgs.alacritty}"
        "$mainMod, E, exec, ${lib.getExe pkgs.pcmanfm}"
      ];

      exec-once = lib.mkAfter [
        "[workspace 1 silent] alacritty"
        "[workspace 1 silent] firefox"
        "[workspace 2 silent] telegram-desktop"
        "[workspace 2 silent] vesktop"
        "[workspace 3 silent] codium"
        "[workspace 4 silent] pcmanfm"
        "[workspace 5 silent] betterbird"
        "[workspace 7 silent] keepassxc"
        "[workspace 10 silent] spotify"
      ];

      windowrulev2 = [
        "workspace 2 silent, class:(vesktop)"
        "workspace 3 silent, class:(codium-url-handler)"
      ];
    };
  };

  # TODO: dehardcodify
  home.file = lib.mkIf (osConfig.networking.hostName == "sleipnir") {
    "dotssh-dir-symlink" = {
      target = ".ssh";
      source = config.lib.file.mkOutOfStoreSymlink "/data/passport/ssh";
    };
    "music-dir-symlink" = {
      target = "music";
      source = config.lib.file.mkOutOfStoreSymlink "/data/archive/music";
    };
    "pictures-dir-symlink" = {
      target = "pictures";
      source = config.lib.file.mkOutOfStoreSymlink "/data/archive/pictures";
    };
    "videos-dir-symlink" = {
      target = "videos";
      source = config.lib.file.mkOutOfStoreSymlink "/data/archive/videos";
    };
    "documents-dir-symlink" = {
      target = "documents";
      source = config.lib.file.mkOutOfStoreSymlink "/data/archive/documents";
    };
  };
}
