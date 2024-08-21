{ pkgs, lib, config, ... }:
with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;
{
  options = {
    programs.waybar.enableBatteryIndicator = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = {
    stylix.targets.waybar.enable = false;

    programs.waybar = {
      enable = config.wayland.windowManager.hyprland.enable;
      systemd.enable = config.wayland.windowManager.hyprland.enable;

      package = pkgs.waybar;

      settings = {
        mainBar = {
          layer = "bottom";
          postition = "top";
          margin-top = 10;
          margin-bottom = 0; # hyprland already added gap
          margin-left = 10;
          margin-right = 10;
          "hyprland/workspaces" = {
            all-outputs = false;
            format = "{name}";
            disable-scroll = false;
            disable-click = false;
          };
          "hyprland/window" = {
            format = "{class}";
          };
          clock = {
            format = "{:L%A, %d %B %Y - %H:%M:%S}";
            interval = 1;
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            locale = "ru_RU.UTF-8";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                days = "<span color='${base05}'><b>{}</b></span>";
                months = "<span color='${base0B}'><b>{}</b></span>";
                weeks = "<span color='${base08}'><b>W{}</b></span>";
                weekdays = "<span color='${base08}'><b>{}</b></span>";
                today = "<span color='${base0D}'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
          wireplumber = {
            format = "{volume}% {icon}";
            format-icons = [ "" "" "" ];
            tooltip = true;
            tooltip-format = "{node_name}";
            max-volume = 150.0;
            on-click = lib.getExe pkgs.pavucontrol;
          };
          "hyprland/language" = {
            format = "{}";
            format-en = "EN";
            format-ru = "RU";
          };
        };
      };

      style = ''
        /* colors in comments are examples, not actual color scheme */
        @define-color base00 ${base00}; /* #00211f Default Background */
        @define-color base01 ${base01}; /* #003a38 Lighter Background (Used for status bars, line number and folding marks) */
        @define-color base02 ${base02}; /* #005453 Selection Background */
        @define-color base03 ${base03}; /* #ababab Comments, Invisibles, Line Highlighting */
        @define-color base04 ${base04}; /* #c3c3c3 Dark Foreground (Used for status bars) */
        @define-color base05 ${base05}; /* #dcdcdc Default Foreground, Caret, Delimiters, Operators */
        @define-color base06 ${base06}; /* #efefef Light Foreground (Not often used) */
        @define-color base07 ${base07}; /* #f5f5f5 Brightest Foreground (Not often used) */
        @define-color base08 ${base08}; /* #ce7e8e Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted */
        @define-color base09 ${base09}; /* #dca37c Integers, Boolean, Constants, XML Attributes, Markup Link Url */
        @define-color base0A ${base0A}; /* #bfac4e Classes, Markup Bold, Search Text Background */
        @define-color base0B ${base0B}; /* #56c16f Strings, Inherited Class, Markup Code, Diff Inserted */
        @define-color base0C ${base0C}; /* #62c0be Support, Regular Expressions, Escape Characters, Markup Quotes */
        @define-color base0D ${base0D}; /* #88b0da Functions, Methods, Attribute IDs, Headings */
        @define-color base0E ${base0E}; /* #b39be0 Keywords, Storage, Selector, Markup Italic, Diff Changed */
        @define-color base0F ${base0F}; /* #d89aba Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?> */


        * {
          font-family: "${sansSerif.name}";
          font-size: ${builtins.toString sizes.desktop}pt;
        }

        #waybar {
          background-color: @base00;
          color: @base05;
          border-radius: 17px;
          border: 2px solid @base0D;
          padding: 10px 10px;
        }

        #waybar.hidden {
          opacity: 0.1;
        }

        .modules-left > * > *,
        .modules-right > * > *,
        .modules-center > * > * {
          padding: 0px 6px;
          margin: 12px 6px;
          background-color: @base01;
          border-radius: 7.5px;
          border: 0.5px solid @base02;
        }

        .modules-left > :first-child > * {
          margin-left: 12px;
        }

        .modules-right > :last-child > * {
          margin-right: 12px;
        }

        #workspaces {
          padding: 0px 0px;
        }

        #workspaces > * {
          padding: 0px 3px;
          border-radius: 7px;
          margin: 0px 0px; 
        }

        #workspaces .active {
          background-color: @base02;
        }

        #tray > widget > image {
          margin: 0px 6px;
        }
      '';
    };
  };
}
