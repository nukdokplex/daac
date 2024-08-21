{ ... }: {
  services.greetd = {
    enable = true;

    settings.vt = 2;
  };
}