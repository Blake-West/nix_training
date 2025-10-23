{ config, modulesPath, ... }:
let
  helloPort = config.services.hello.port;
in
{
  imports = [
    # The qemu-vm NixOS module gives us the `vm` attribute that we will later
    # use, and other VM-related settings
    "${modulesPath}/virtualisation/qemu-vm.nix"
  ];

  documentation.nixos.enable = false;

  # Forward the hosts's port 2222 to the guest's SSH port.
  virtualisation.forwardPorts = [
    # on the training machine, select different port numbers on the host side,
    # because you might otherwise clash with other class participants who run
    # this on the same machine and then block each other.
    { from = "host"; host.port = 2222; guest.port = 22; }
    { from = "host"; host.port = helloPort; guest.port = helloPort; }
  ];

  # Root user without password and enabled SSH for playing around
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PermitEmptyPasswords = "yes";
    };
  };
  security.pam.services.sshd.allowNullPassword = true;
  users.extraUsers.root.password = "";

  # If you're running this on the shared training-machine, set this to false
  # On a laptop with nix, KVM and graphical desktop, set it to true
  virtualisation.graphics = false;
}
