{ config, pkgs, lib, ... }:
let
  colors = with config.lib.stylix.colors.withHashtag; {
    accent = base0D;
    background = base00;
    background-alt = base01;
    foreground = base05;
  };
  font = config.stylix.fonts.sansSerif.name;
  font-size = config.stylix.fonts.sizes.popups;
  rounding = 12;
in
{
  options.custom.wofi.enable = lib.mkEnableOption "wofi custom config";
  config = lib.mkIf config.custom.wofi.enable {
    home.packages = with pkgs; [ wofi-emoji ];

    programs.wofi = {
      enable = true;
      settings = {
        allow_markup = true;
        width = 450;
        prompt = "Apps";
        normal_window = true;
        layer = "top";
        term = "foot";
        height = "305px";
        orientation = "vertical";
        halign = "fill";
        line_wrap = "off";
        dynamic_lines = false;
        allow_images = true;
        image_size = 24;
        exec_search = false;
        hide_search = false;
        parse_search = false;
        insensitive = true;
        hide_scroll = true;
        no_actions = true;
        sort_order = "default";
        gtk_dark = true;
        filter_rate = 100;
        key_expand = "Tab";
        key_exit = "Escape";
      };

      style = lib.mkForce
        # css
        ''
          * {
            font-family: "${font}";
            font-weight: 500;
            font-size: ${toString font-size}px;
          }

          #window {
            background-color: ${colors.background};
            color: ${colors.foreground};
            border-radius: ${toString rounding}px;
          }

          #outer-box {
            padding: 20px;
          }

          #input {
            background-color: ${colors.background-alt};
            border: 0px solid ${colors.accent};
            color: ${colors.foreground};
            padding: 8px 12px;
          }

          #scroll {
            margin-top: 20px;
          }

          #inner-box {}

          #img {
            padding-right: 8px;
          }

          #text {
            color: ${colors.foreground};
          }

          #text:selected {
            color: ${colors.foreground};
          }

          #entry {
            padding: 6px;
          }

          #entry:selected {
            background-color: ${colors.accent};
            color: ${colors.foreground};
          }

          #unselected {}

          #selected {}

          #input,
          #entry:selected {
            border-radius: ${toString rounding}px;
          }
        '';
    };
  };
}
