{ lib, config, pkgs, ... }:
let
  cfg = config.cor.home.apps.rofi;
  fontConfig = ''
    * {
      font: "JetBrains Mono Nerd Font 10";
    }
  '';
  colorConfig = ''
    * {
      rosewater: #f5e0dcff;
      flamingo: #f2cdcdff;
      pink: #f5c2e7ff;
      mauve: #cba6f7ff;
      red: #f38ba8ff;
      maroon: #eba0acff;
      peach: #fab387ff;
      yellow: #f9e2afff;
      green: #a6e3a1ff;
      teal: #94e2d5ff;
      sky: #89dcebff;
      sapphire: #74c7ecff;
      blue: #89b4faff;
      lavender: #b4befeff;
      text: #cdd6f4ff;
      subtext1: #bac2deff;
      subtext0: #a6adc8ff;
      overlay2: #9399b2ff;
      overlay1: #7f849cff;
      overlay0: #6c7086ff;
      surface2: #585b70ff;
      surface1: #45475aff;
      surface0: #313244ff;
      base: #1e1e2eff;
      mantle: #181825ff;
      crust: #11111bff;
      accent: var(green);
    }
  '';

  poweroff = "systemctl poweroff";
  reboot = "systemctl reboot";
  lock = "loginctl lock-session";
  suspend = "systemctl suspend";
  logout = "loginctl terminate-session";
in
{
  options.cor.home.apps.rofi = {
    enable = lib.cor.mkEnableOption false "Enable rofi in current Home Manager configuration.";

    package = lib.mkOption {
      default = pkgs.rofi-wayland;
      defaultText = "pkgs.rofi-wayland";
      description = "Rofi package.";
      type = lib.types.package;
    };

    enableHyprlandIntegration = lib.cor.mkEnableOption
      true
      "Whether to enable rofi integration with hyprland in current Home Manager configration"
    ;
  };

  config = lib.mkIf cfg.enable rec {
    home.packages = [ cfg.package ];

    xdg.configFile.rofi-launcher = {
      target = "rofi/config.rasi";
      text = ''
        configuration {
          modi:                       "drun,run,filebrowser,window";
            show-icons:                 true;
            display-drun:               " Apps";
            display-run:                " Run";
            display-filebrowser:        " Files";
            display-window:             " Windows";
          drun-display-format:        "{name}";
          window-format:              "{w} · {c} · {t}";
        }

        ${fontConfig}
        ${colorConfig}

        * {
            border-colour:               var(accent);
            handle-colour:               var(accent);
            background-colour:           var(base);
            foreground-colour:           var(text);
            alternate-background:        var(surface0);
            normal-background:           var(base);
            normal-foreground:           var(text);
            urgent-background:           var(red);
            urgent-foreground:           var(base);
            active-background:           var(accent);
            active-foreground:           var(base);
            selected-normal-background:  var(accent);
            selected-normal-foreground:  var(base);
            selected-urgent-background:  var(red);
            selected-urgent-foreground:  var(base);
            selected-active-background:  var(red);
            selected-active-foreground:  var(base);
            alternate-normal-background: var(surface0);
            alternate-normal-foreground: var(text);
            alternate-urgent-background: var(red);
            alternate-urgent-foreground: var(base);
            alternate-active-background: var(accent);
            alternate-active-foreground: var(base);
        }

        /*****----- Main Window -----*****/
        window {
            /* properties for window widget */
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  false;
            width:                       800px;
            x-offset:                    0px;
            y-offset:                    0px;

            /* properties for all widgets */
            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               10px;
            border-color:                @border-colour;
            cursor:                      "default";
            /* Backgroud Colors */
            background-color:            @background-colour;
            /* Backgroud Image */
            //background-image:          url("/path/to/image.png", none);
            /* Simple Linear Gradient */
            //background-image:          linear-gradient(red, orange, pink, purple);
            /* Directional Linear Gradient */
            //background-image:          linear-gradient(to bottom, pink, yellow, magenta);
            /* Angle Linear Gradient */
            //background-image:          linear-gradient(45, cyan, purple, indigo);
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     20px;
            border:                      0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @border-colour;
            background-color:            transparent;
            children:                    [ "inputbar", "mode-switcher", "message", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
            children:                    [ "textbox-prompt-colon", "entry" ];
        }

        prompt {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
        }
        textbox-prompt-colon {
            enabled:                     true;
            padding:                     5px 0px;
            expand:                      false;
            str:                         "";
            background-color:            inherit;
            text-color:                  inherit;
        }
        entry {
            enabled:                     true;
            padding:                     5px 0px;
            background-color:            inherit;
            text-color:                  inherit;
            cursor:                      text;
            placeholder:                 "Search...";
            placeholder-color:           inherit;
        }
        num-filtered-rows {
            enabled:                     true;
            expand:                      false;
            background-color:            inherit;
            text-color:                  inherit;
        }
        textbox-num-sep {
            enabled:                     true;
            expand:                      false;
            str:                         "/";
            background-color:            inherit;
            text-color:                  inherit;
        }
        num-rows {
            enabled:                     true;
            expand:                      false;
            background-color:            inherit;
            text-color:                  inherit;
        }
        case-indicator {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     1;
            lines:                       8;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;
          
            spacing:                     5px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
            cursor:                      "default";
        }
        scrollbar {
            handle-width:                5px ;
            handle-color:                @handle-colour;
            border-radius:               10px;
            background-color:            @alternate-background;
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     10px;
            border:                      0px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
            cursor:                      pointer;
        }
        element normal.normal {
            background-color:            var(normal-background);
            text-color:                  var(normal-foreground);
        }
        element normal.urgent {
            background-color:            var(urgent-background);
            text-color:                  var(urgent-foreground);
        }
        element normal.active {
            background-color:            var(active-background);
            text-color:                  var(active-foreground);
        }
        element selected.normal {
            background-color:            var(selected-normal-background);
            text-color:                  var(selected-normal-foreground);
        }
        element selected.urgent {
            background-color:            var(selected-urgent-background);
            text-color:                  var(selected-urgent-foreground);
        }
        element selected.active {
            background-color:            var(selected-active-background);
            text-color:                  var(selected-active-foreground);
        }
        element alternate.normal {
            background-color:            var(alternate-normal-background);
            text-color:                  var(alternate-normal-foreground);
        }
        element alternate.urgent {
            background-color:            var(alternate-urgent-background);
            text-color:                  var(alternate-urgent-foreground);
        }
        element alternate.active {
            background-color:            var(alternate-active-background);
            text-color:                  var(alternate-active-foreground);
        }
        element-icon {
            background-color:            transparent;
            text-color:                  inherit;
            size:                        24px;
            cursor:                      inherit;
        }
        element-text {
            background-color:            transparent;
            text-color:                  inherit;
            highlight:                   inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.0;
        }

        /*****----- Mode Switcher -----*****/
        mode-switcher{
            enabled:                     true;
            expand:                      false;
            spacing:                     10px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
        }
        button {
            padding:                     12px;
            border:                      0px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            @alternate-background;
            text-color:                  inherit;
            cursor:                      pointer;
        }
        button selected {
            background-color:            var(selected-normal-background);
            text-color:                  var(selected-normal-foreground);
        }

        /*****----- Message -----*****/
        message {
            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
        }
        textbox {
            padding:                     12px;
            border:                      0px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            @alternate-background;
            text-color:                  @foreground-colour;
            vertical-align:              0.5;
            horizontal-align:            0.0;
            highlight:                   none;
            placeholder-color:           @foreground-colour;
            blink:                       true;
            markup:                      true;
        }
        error-message {
            padding:                     0px;
            border:                      2px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            @background-colour;
            text-color:                  @foreground-colour;
        }
      '';
    };
    xdg.configFile.rofi-powermenu = {
      target = "rofi/powermenu.rasi";
      text = ''
        /*****----- Configuration -----*****/
        configuration {
            show-icons:                 false;
        }

        /*****----- Global Properties -----*****/
        ${fontConfig}
        ${colorConfig}

        /*
        USE_BUTTONS=YES
        */

        /*****----- Main Window -----*****/
        window {
            /* properties for window widget */
            transparency:                "real";
            location:                    east;
            anchor:                      east;
            fullscreen:                  false;
            width:                       115px;
            x-offset:                    -15px;
            y-offset:                    0px;

            /* properties for all widgets */
            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               12px;
            border-color:                var(accent);
            cursor:                      "default";
            background-color:            var(base);
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     15px;
            margin:                      0px;
            padding:                     15px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                var(accent);
            background-color:            transparent;
            children:                    [ "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     0px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px;
            border-radius:               0px;
            border-color:                var(accent);
            background-color:            transparent;
            text-color:                  var(text);
            children:                    [ "textbox-prompt-colon", "prompt"];
        }

        dummy {
            background-color:            transparent;
        }

        textbox-prompt-colon {
            enabled:                     true;
            expand:                      false;
            str:                         "";
            padding:                     12px 16px;
            border-radius:               0px;
            background-color:            var(red);
            text-color:                  var(base);
        }
        prompt {
            enabled:                     true;
            padding:                     12px;
            border-radius:               0px;
            background-color:            var(accent);
            text-color:                  var(text);
        }

        /*****----- Message -----*****/
        message {
            enabled:                     true;
            margin:                      0px;
            padding:                     12px;
            border:                      0px solid;
            border-radius:               100%;
            border-color:                var(accent);
            background-color:            var(surface0);
            text-color:                  var(text);
        }
        textbox {
            background-color:            inherit;
            text-color:                  inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
            placeholder-color:           var(text);
            blink:                       true;
            markup:                      true;
        }
        error-message {
            padding:                     12px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                var(accent);
            background-color:            var(base);
            text-color:                  var(text);
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     1;
            lines:                       5;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;
          
            spacing:                     15px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                var(accent);
            background-color:            transparent;
            text-color:                  var(text);
            cursor:                      "default";
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     0px;
            margin:                      0px;
            padding:                     20px 0px;
            border:                      0px solid;
            border-radius:               100%;
            border-color:                var(accent);
            background-color:            var(base);
            text-color:                  var(text);
            cursor:                      pointer;
        }
        element-text {
            font:                        "feather bold 24";
            background-color:            transparent;
            text-color:                  inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }
        element selected.normal {
            background-color:            var(accent);
            text-color:                  var(base);
        }
      '';
    };
    xdg.configFile.rofi-powermenu-script = {
      target = "rofi/powermenu.sh";
      executable = true;
      text = ''
        #!/usr/bin/env bash

        # CMDs
        uptime="`uptime -p | sed -e 's/up //g'`"
        host=`hostname`

        # Options
        shutdown='󰐥'
        reboot='󰑐'
        lock='󰌾'
        suspend='󰤄'
        logout='󰍃'

        # Rofi CMD
        rofi_cmd() {
          rofi -dmenu \
            -p "Uptime: $uptime" \
            -mesg "Uptime: $uptime" \
            -theme ${config.xdg.configHome}/rofi/powermenu.rasi
        }

        # Pass variables to rofi dmenu
        run_rofi() {
          echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
        }

        # Actions
        chosen="$(run_rofi)"
        case ''${chosen} in
          $shutdown)
            ${poweroff}
            ;;
          $reboot)
            ${reboot}
            ;;
          $lock)
            ${lock}
            ;;
          $suspend)
            ${suspend}
            ;;
          $logout)
            ${logout}
            ;;
        esac
      '';
    };
    wayland.windowManager.hyprland.settings.bind = lib.mkIf cfg.enableHyprlandIntegration [
      "$mainMod, R, exec, rofi -show drun"
      "CTRL + ALT, Delete, exec, sh ${config.home.homeDirectory}/${xdg.configFile.rofi-powermenu-script.target}"
    ];
  };
}
