{ config, lib, pkgs, ... }:
let
  cat = lib.getExe' pkgs.coreutils "cat";
  mkPasswordCommand = secret: "${cat} ${secret}";
  defaultThunderbirdProfileName = "nukdokplex";
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
        passwordCommand = mkPasswordCommand config.age.secrets.${address}.path;
        primary = true;
        thunderbird = {
          enable = true;
          profiles = [ defaultThunderbirdProfileName ];
        };
        imap = {
          host = "mail.nukdotcom.ru";
          port = 993;
          tls.enable = true;
        };
        smtp = {
          host = "mail.nukdotcom.ru";
          port = 465;
          tls.enable = true;
        };
      };
      "nukdokplex@outlook.com" = let address = "nukdokplex@outlook.com"; in {
        inherit address realName;
        userName = address;
        passwordCommand = mkPasswordCommand config.age.secrets.${address}.path;
        thunderbird = {
          enable = true;
          profiles = [ defaultThunderbirdProfileName ];
        };
        flavor = "outlook.office365.com";
      };
      "vik.titoff2014@gmail.com" = let address = "vik.titoff2014@gmail.com"; in {
        inherit address realName;
        userName = address;
        passwordCommand = mkPasswordCommand config.age.secrets.${address}.path;
        thunderbird = {
          enable = true;
          profiles = [ defaultThunderbirdProfileName ];
        };
        flavor = "gmail.com";
      };
      "vik.titoff2014@yandex.ru" = let address = "vik.titoff2014@yandex.ru"; in {
        inherit address realName;
        userName = address;
        passwordCommand = mkPasswordCommand config.age.secrets.${address}.path;
        thunderbird = {
          enable = true;
          profiles = [ defaultThunderbirdProfileName ];
        };
        imap = {
          host = "imap.yandex.ru";
          port = 993;
          tls.enable = true;
        };
        smtp = {
          host = "smtp.yandex.ru";
          port = 465;
          tls.enable = true;
        };
      };
    };

  programs.thunderbird = {
    package = pkgs.betterbird;
    profiles.${defaultThunderbirdProfileName} = {
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
