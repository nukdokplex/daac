{
  self,
  lib,
  osConfig,
  pkgs,
  ...
}: 
let pkgs-unstable = import self.inputs.nixpkgs-unstable {system = osConfig.nixpkgs.hostPlatform.system;}; in {
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;

    extensions = with self.inputs.vscode-extensions.extensions.${osConfig.nixpkgs.hostPlatform.system}.open-vsx; [
      jnoortheen.nix-ide      
      naumovs.color-highlight
      leonardssh.vscord
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
        nixd.formatting = {
          command = [(lib.getExe self.formatter.${osConfig.nixpkgs.hostPlatform.system})];
        };
      };
    };
  };
}
