let
  hostPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaI1J1wi4HhDvfp+glq29fEFCBq4jKSmyGe4FUbBWTX"
  ];
in
{
  "yggdrasil.age".publicKeys = hostPublicKeys;
}
