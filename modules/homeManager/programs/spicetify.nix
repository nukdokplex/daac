{ self
, pkgs
, ...
}: {
  imports = [ self.inputs.spicetify-nix.homeManagerModules.default ];

  # curl -H 'X-Ubuntu-Series: 16' 'https://api.snapcraft.io/api/v1/snaps/details/spotify?channel=stable' | jq '.download_url,.version,.last_updated'

  stylix.targets.spicetify.enable = false; # stylix looks ugly on spicetify

  programs.spicetify =
    let
      spicePkgs = self.inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      spotifyPackage = pkgs.spotify;
      windowManagerPatch = true;
      spotifyLaunchFlags = "--ozone-platform=x11"; # wm patch works only when spotify runs in x11 mode

      theme = spicePkgs.themes.onepunch; # pretty cool gruvbox theme

      enabledExtensions = with spicePkgs.extensions; [
        betterGenres
        showQueueDuration
        songStats
      ];

      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        reddit
      ];
    };
}
