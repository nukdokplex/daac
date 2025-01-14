let
  hostPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaI1J1wi4HhDvfp+glq29fEFCBq4jKSmyGe4FUbBWTX"
  ];
in
{
  "sing-box/vless-out-uuid.age".publicKeys = hostPublicKeys;
  "sing-box/vless-out-short_id.age".publicKeys = hostPublicKeys;
}
