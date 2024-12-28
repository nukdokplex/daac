{ pkgs, ... }: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        toml
        vim
        vimdoc
        xml
        yaml
      ];
    };
    oil = {
      enable = true;
      settings = {
        columns = [ "icons" ];
        keymaps = {
          "-" = "actions.parent";
        };
        win_options = {
          spell = false;
          wrap = false;
          concealcursor = "ncv";
          conceallevel = 3;
          cursorcolumn = false;
        };
      };
    };
    fzf-lua = {
      enable = true;
    };
    nix.enable = true;
    nvim-surround.enable = true;
    web-devicons = {
      enable = true;
      settings = {
        color_icons = true;
        strict = true;
      };
    };
  };
}
