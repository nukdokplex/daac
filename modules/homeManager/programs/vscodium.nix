{ self
, lib
, pkgs
, ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with self.inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.open-vsx; [
      jnoortheen.nix-ide
      naumovs.color-highlight
      leonardssh.vscord
      arrterian.nix-env-selector
      ms-python.python
      ms-python.black-formatter
      ms-python.debugpy
      vue.volar
      # ms-toolsai.jupyter
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
          command = [ (lib.getExe self.formatter.${osConfig.nixpkgs.hostPlatform.system}) ];
        };
      };

      "vscord.app.name" = "VSCodium";
      "vscord.status.idle.disconnectOnIdle" = true;
      "vscord.app.privacyMode.enable" = true;
      "vscord.app.whitelist" = [
        "273784375764582401"
      ];
    };
  };
}
