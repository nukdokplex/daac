{ config, lib, pkgs, ... }:
let
  mkPasswordCommand = secret: "${lib.getExe' pkgs.coreutils "cat"} ${secret}";
  mkEmailPasswordCommand = email: mkPasswordCommand config.agenix.secrets.${email}.path;
in
{
  accounts.email.accounts =
    let
      realName = "Viktor Titov";
    in
    {
      "nukdokplex@nukdokplex.ru" = let address = "nukdokplex@nukdokplex.ru"; in {
        inherit address realName;
        userName = address;
        passwordCommand = mkEmailPasswordCommand address;
        primary = true;
        thunderbird = {
          enable = true;
          profiles = [ "default" ];
        };
      };
      "nukdokplex@outlook.com" = let address = "nukdokplex@outlook.com"; in {
        inherit address realName;
        userName = address;
        passwordCommand = mkEmailPasswordCommand address;
        thunderbird = {
          enable = true;
          profiles = [ "default" ];
        };
      };
      "vik.titoff2014@gmail.com" = let address = "vik.titoff2014@gmail.com"; in {
        inherit address realName;
        userName = address;
        passwordCommand = mkEmailPasswordCommand address;
        thunderbird = {
          enable = true;
          profiles = [ "default" ];
        };
      };
      "vik.titoff2014@yandex.ru" = let address = "vik.titoff2014@yandex.ru"; in {
        inherit address realName;
        userName = address;
        passwordCommand = mkEmailPasswordCommand address;
        thunderbird = {
          enable = true;
          profiles = [ "default" ];
        };
      };
    };

  programs.thunderbird = {
    package = pkgs.betterbird;
    profiles.default = {
      isDefault = true;
      settings = {
        "calendar.timezone.useSystemTimezone" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "mail.tabs.drawInTitlebar" = false;
        "mailnews.default_sort_order" = 2; # descending, 1 for ascending
        "mailnews.default_sort_type" = 18; # sort by date
        "mailnews.message_display.disable_remote_image" = false;
        "network.cookie.cookieBehavior" = 2; # no cookies
        "pdfjs.enabledCache.state" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.firstparty.isolate" = true;
        "privacy.purge_trackers.date_in_cookie_database" = "0";
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "svg.context-properties.content.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.enabled" = false;
      };
    };
  };
}
