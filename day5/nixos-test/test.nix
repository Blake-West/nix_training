# While working on this task, keep the NixOS Integration Test Driver
# documentation in a browser tab:
#
# https://nixos.org/manual/nixos/stable/index.html#sec-nixos-tests

{
  name = "HelloTest";

  # We can set defaults that are applied to all machines
  defaults = {
    #networking.firewall.enable = false;
  };

  nodes = {
    server = import ./configuration.nix;

    client = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        netcat
      ];
    };
  };

  testScript = { nodes, ... }: ''
    start_all()

    # The VM from above is available as object `machine`, because that is its
    # name in the `nodes` attribute set.
    server.systemctl("start network-online.target")
    server.wait_for_unit("network-online.target")

    client.systemctl("start network-online.target")
    client.wait_for_unit("network-online.target")

    # The NixOS Integration Test Driver Documentation (which you hopefully
    # keep open in a browser tab) tells you which Python object methods are
    # available for your testing needs

    # output = server.succeed("nc localhost 8081 < /dev/null")
    output = client.succeed("nc server 8081 < /dev/null")
    print(f"Output from our client: {output}")
    assert "Hello, world!" in output, "GNU Hello Output matches"
  '';
}
