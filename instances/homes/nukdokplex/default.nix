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
      mpv
      libreoffice-fresh
      tor-browser
      kdePackages.k3b
      thunderbird
      gedit
      chromium
      kdePackages.kdenlive
      osu-lazer-bin
      opentabletdriver
      yt-dlp
      imv
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
    ranger = {
      enable = true;
      package = pkgs.ranger.override {
        imagePreviewSupport = true;
        sixelPreviewSupport = true;
        neoVimSupport = true;
        improvedEncodingDetection = true;
      };
    };
    waybar.enable = true;
    spicetify.enable = true;
    nixvim = {
      enable = true;
      plugins = {
        nix-develop.enable = true;
      };
    };
    kodi = {
      enable = true;
    };
    wpaperd = {
      enable = true;
      settings = {
        "LG Electronics LG ULTRAWIDE 0x00000459" = {
          path = "${pkgs.nur.repos.nukdokplex.gruvbox-wallpapers.irl}";
          duration = "30s";
          sorting = "random";
          mode = "center";
          transition-time = 1000;
          queue-size = 40;
          initial-transition = true;
        };
        "LG Display 0x05F6 Unknown" = {
          path = "${pkgs.nur.repos.nukdokplex.gruvbox-wallpapers.anime}";
          duration = "30s";
          sorting = "random";
          mode = "center";
          transition-time = 1000;
          queue-size = 40;
          initial-transition = true;
        };
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableZshIntegration = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
    syncthing.enable = true;
    arrpc.enable = true;
  };

  custom.gaming.enable = true;

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, U, exec, firefox"
        "$mainMod, I, exec, alacritty"
        "$mainMod, N, exec, alacritty -- ranger"
      ];

      exec-once = lib.mkAfter [
        "[workspace 1 silent] firefox"
        "[workspace 2 silent] telegram-desktop"
        "[workspace 2 silent] vesktop"
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
  stylix.targets.wpaperd.enable = false;
  wayland.windowManager.sway.config = {
    input = {
      "type:keyboard" = {
        "xkb_layout" = "us,ru";
        "xkb_options" = "grp:ctrl_space_toggle,compose:ralt";
      };
    };
    startup = [
      { command = "'${lib.getExe config.programs.wpaperd.package}' -d"; }
      { command = "firefox"; }
      { command = "telegram-desktop"; }
      { command = "vesktop"; }
      { command = "thunderbird"; }
      { command = "keepassxc"; }
      { command = "spotify"; }
    ];
    assigns = {
      "2" = [{ app_id = "org.telegram.desktop"; } { class = "vesktop"; }];
      "5" = [{ app_id = "thunderbird"; }];
      "7" = [{ app_id = "org.keepassxc.KeePassXC"; }];
      "10" = [{ class = "Spotify"; }];
    };
    keybindings = with config.wayland.windowManager.sway.config; {
      "${modifier}+u" = "exec firefox";
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

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };
}
