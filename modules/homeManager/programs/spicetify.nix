{ self
, pkgs
, ...
}: {
  imports = [ self.inputs.spicetify-nix.homeManagerModules.default ];

  # curl -H 'X-Ubuntu-Series: 16' 'https://api.snapcraft.io/api/v1/snaps/details/spotify?channel=stable' | jq '.download_url,.version,.last_updated'

  nixpkgs.overlays = [
    (final: prev:
      let
        version = "1.2.48.405.gf2c48e6f";
        rev = "80";
      in
      {
        spotify = prev.spotify.overrideAttrs {
          inherit version rev;
          src = prev.fetchurl {
            name = "spotify-${version}-${rev}.snap";
            url = "https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_${rev}.snap";
            hash = "sha512-F1Npz/oKCsMKaQx2M5dm1dhWhaSlt8422tpRWnwuk2yjwLWrOYDY2uKYph8YFXfOdS3mV6u5yVlzgFdDqAFmCQ==";
          };
          unpackPhase = ''
            runHook preUnpack
            unsquashfs "$src" '/usr/share/spotify' '/usr/bin/spotify' '/meta/snap.yaml'
            cd squashfs-root
            if ! grep -q 'grade: stable' meta/snap.yaml; then
              # Unfortunately this check is not reliable: At the moment (2018-07-26) the
              # latest version in the "edge" channel is also marked as stable.
              echo "The snap package is marked as unstable:"
              grep 'grade: ' meta/snap.yaml
              echo "You probably chose the wrong revision."
              exit 1
            fi
            if ! grep -q '${version}' meta/snap.yaml; then
              echo "Package version differs from version found in snap metadata:"
              grep 'version: ' meta/snap.yaml
              echo "While the nix package specifies: ${version}."
              echo "You probably chose the wrong revision or forgot to update the nix version."
              exit 1
            fi
            runHook postUnpack
          '';
        };
      })
  ];

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
        beautifulLyrics
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
