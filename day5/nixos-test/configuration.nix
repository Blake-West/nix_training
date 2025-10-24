_:

{
  imports = [
    ./hello-as-a-service.nix
  ];

  services.hello.enable = true;
  services.hello.openFirewall = true;

  networking.firewall.enable = true;

  system.stateVersion = "22.11";
}
