{ pkgs, lib, ... }:
let open-tui = pkgs.writeShellScript "open-tui" (builtins.readFile ./scripts/open-tui.sh); in {
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = "nvim.desktop";
      "image/*" = "imv-folder.desktop";
      "audio/*" = "mpv.desktop";
      "video/*" = "mpv.desktop";
      "inode/directory" = "xranger.desktop";

      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "application/vnd.mozilla.xul+xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };
}
