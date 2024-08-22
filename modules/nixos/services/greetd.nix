{ ... }: {
  services.greetd = {
    enable = true;

    settings.vt = 2;
  };

  systemd.services.greetd = {
    serviceConfig.type = "idle";
    unitConfig.After = [ "docker.service" ];
  };
}