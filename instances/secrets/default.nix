{ ... }: {
  age.secrets = {
    nukdokplexPasswordFile.file = ./userPasswordFiles/nukdokplex.age;
  };

  # hardcode those values, somehow agenix doesn't see that openssh service is enabled
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
  ];
}
