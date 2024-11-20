{ self
, config
, osConfig
, lib
, pkgs
, ...
}:
let
  username = "nukdokplex";
in
{
  imports = [
    self.modules.homeManager.default
    self.inputs.agenix.homeManagerModules.age
    ./mime.nix
  ];

  home = {
    stateVersion = "24.05"; # TODO: dehardcodify
    homeDirectory = "/home/${username}";
    inherit username;

    packages = with pkgs; [
      vesktop
      telegram-desktop
      keepassxc
      qbittorrent
      vlc
      libreoffice-fresh
      tor-browser
      kdePackages.k3b
      thunderbird
      gedit
      shotwell
      chromium
      peazip
      kdePackages.kdenlive
      osu-lazer-bin
      opentabletdriver
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
    gpg = {
      enable = true;
    };
    thunar = {
      enable = true;
      setDefault = true;
    };
    waybar.enable = true;
    spicetify.enable = true;
    neovim = {
      enable = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  services.syncthing.enable = true;

  custom.gaming.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    # TODO: these packages are hardcoded

    settings = {
      bind = [
        "$mainMod, W, exec, firefox"
        "$mainMod, Q, exec, ${lib.getExe pkgs.alacritty}"
        "$mainMod, E, exec, thunar"
      ];

      exec-once = lib.mkAfter [
        "[workspace 1 silent] alacritty"
        "[workspace 1 silent] firefox"
        "[workspace 2 silent] telegram-desktop"
        "[workspace 2 silent] vesktop"
        "[workspace 3 silent] codium"
        "[workspace 4 silent] thunar"
        "[workspace 5 silent] thunderbird"
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
