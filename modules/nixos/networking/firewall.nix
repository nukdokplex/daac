{
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22000 ];
  };
}
