{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    policies = {
      Cookies = {
        Behavior = "reject-foreign";
        BehaviorPrivateBrowsing = "reject-foreign";
      };

      DisableAppUpdate = true;
      DisableFirefoxStudies = true;
      DisableMasterPasswordCreation = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;

      DisplayBookmarksToolbar = "newtab";

      DNSOverHTTPS = {
        Enabled = false;
      };

      DontCheckDefaultBrowser = true;

      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };

      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = false;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # "FirefoxColor@mozilla.com" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
        #   installation_mode = "force_installed";
        # };
        # "{207f15ad-ca52-44b2-bc01-27330dbe6889}" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/piped-redirects/latest.xpi";
        #   installation_mode = "force_installed";
        # };
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      ExtensionUpdate = true;

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = false;
      };

      FirefoxSuggest = {
        ImproveSuggest = false;
        Locked = false;
        SponsoredSuggestions = false;
        WebSuggestions = false;
      };

      HardwareAcceleration = true;

      Homepage = {
        Locked = false;
        StartPage = "previous-session";
      };

      NewTabPage = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;

      PDFjs = {
        Enabled = true;
        EnablePermissions = false;
      };

      Preferences = {
        "browser.aboutConfig.showWarning" = false;
        "browser.bookmarks.addedImportButton" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "dom.security.https_only_mode" = true;
        "extensions.autoDisableScopes" = 0;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "media.navigator.mediadatadecoder_vp8_hardware_enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
      };

      SearchEngines.Default = "DuckDuckGo";

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;
      };

      UseSystemPrintDialog = true;
    };
  };
}
