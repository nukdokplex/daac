let
  hostPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaI1J1wi4HhDvfp+glq29fEFCBq4jKSmyGe4FUbBWTX"
  ];
in
{
  "yggdrasil.age".publicKeys = hostPublicKeys;
  "sb-vless-server.age".publicKeys = hostPublicKeys;
  "sb-vless-uuid.age".publicKeys = hostPublicKeys;
  "sb-vless-public_key.age".publicKeys = hostPublicKeys;
  "sb-vless-short_id.age".publicKeys = hostPublicKeys;
}
