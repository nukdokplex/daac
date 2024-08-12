let
  hostPublicKeys = [
    (builtins.readFile ./publicKeys/gladr_ed25519.pub)
  ];
in {
  "userPasswordFiles/nukdokplex.age".publicKeys = hostPublicKeys;
}