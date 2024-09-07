{
  self,
  lib,
  osConfig,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      naumovs.color-highlight
    ];

    userSettings = {
      "editor.semanticHighlighting.enabled" = true;

      # disable paste and enable multicursor with middle mouse button
      "editor.selectionClipboard" = false;

      # prevent VSCode from modifying the terminal colors
      # "terminal.integrated.minimumContrastRatio" = 1;
      "window.titleBarStyle" = "custom";

      "window.commandCenter" = false;
      "window.menuBarVisibility" = "compact";
      "workbench.layoutControl.enabled" = false;
      "window.dialogStyle" = "custom";

      # nix-ide settings
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = lib.getExe pkgs.nixd;
      "nix.serverSettings" = {
        formatting = {
          command = [self.formatter.${osConfig.nixpkgs.hostPlatform.system}];
        };
      };
    };
  };
}
