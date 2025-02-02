{ self, pkgs, ... }:
let
  username = "nukdokplex";
in
{
  imports = [
    self.modules.homeManager.default
    self.inputs.agenix.homeManagerModules.age
    ./nixvim
    ./sway.nix
    ./hyprland.nix
    ./directories.nix
  ];

  home = {
    stateVersion = "24.05";
    homeDirectory = "/home/${username}";
    inherit username;

    packages = with pkgs; [
      vesktop
      telegram-desktop
      keepassxc
      qbittorrent
      vlc
      mpv
      pqiv
      libreoffice-fresh
      tor-browser
      thunderbird
      gedit
      chromium
      kdePackages.kdenlive
      osu-lazer-bin
      opentabletdriver
      yt-dlp
      obs-cli
    ];
  };

  xfconf.settings.thunar = {
    misc-single-click = false;
    default-view = "ThunarDetailsView";
  };

  programs = {
    git = {
      userName = "nukdokplex";
      userEmail = "nukdokplex@nukdokplex.ru";
    };
    gpg.enable = true;
    nixvim.enable = true;
    ranger = {
      enable = true;
    };
    kodi = {
      enable = true;
      package = pkgs.kodi-wayland.withPackages (exts: [ ]);
    };
    waybar.enable = true;
    spicetify.enable = true;
    wpaperd = {
      enable = true;
      settings = {
        "LG Electronics LG ULTRAWIDE 0x00000459" = {
          path = "${pkgs.nur.repos.nukdokplex.gruvbox-wallpapers.irl}";
          duration = "3m";
          sorting = "random";
          mode = "center";
          transition-time = 1000;
          queue-size = 40;
        };
        "LG Display 0x05F6" = {
          path = "${pkgs.nur.repos.nukdokplex.gruvbox-wallpapers.irl}";
          duration = "3m";
          sorting = "random";
          mode = "center";
          transition-time = 1000;
          queue-size = 40;
        };
      };
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
        waveform
        obs-websocket
        obs-backgroundremoval
        obs-tuna
        obs-vaapi
        obs-vkcapture
        obs-gstreamer
        obs-pipewire-audio-capture
      ];
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

  stylix.targets.wpaperd.enable = false;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };
}
