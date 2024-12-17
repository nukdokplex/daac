{ pkgs, lib, ... }:
let open-tui = pkgs.writeShellScript "open-tui" (builtins.readFile ./scripts/open-tui.sh); in {
  xdg.mime = {
    enable = true;
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "nvim.desktop";
    "image/*" = "imv-folder.desktop";
    "audio/*" = "mpv.desktop";
    "video/*" = "mpv.desktop";
    "inode/directory" = "xranger.desktop";
  };

  xdg.desktopEntries.xranger = {
    name = "xranger";
    type = "Application";
    terminal = false;
    exec = "${lib.getExe open-tui} ranger %F";
    icon = "utilities-terminal";
    mimeType = [ "inode/directory" ];
    categories = [ "System" "FileTools" "FileManager" ];
    comment = "Launches the Ranger file manager";
  };
}
