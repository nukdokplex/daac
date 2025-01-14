let
  hostPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaI1J1wi4HhDvfp+glq29fEFCBq4jKSmyGe4FUbBWTX"
  ];
in
{
  "secureboot/db/db.key.age".publicKeys = hostPublicKeys;
  "secureboot/db/db.pem.age".publicKeys = hostPublicKeys;
  "secureboot/KEK/KEK.key.age".publicKeys = hostPublicKeys;
  "secureboot/KEK/KEK.pem.age".publicKeys = hostPublicKeys;
  "secureboot/PK/PK.key.age".publicKeys = hostPublicKeys;
  "secureboot/PK/PK.pem.age".publicKeys = hostPublicKeys;
  "networkmanager_environment.age".publicKeys = hostPublicKeys;

  "sing-box/vless-out-ip.age".publicKeys = hostPublicKeys;
  "sing-box/vless-out-public_key.age".publicKeys = hostPublicKeys;
}
