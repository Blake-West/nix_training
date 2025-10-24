{ config, pkgs, lib, ... }:
let
  cfg = config.services.hello;
in
{
  options.services.hello = {
    enable = lib.mkEnableOption "GNU-Hello as a Service";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8081;
      description = "Port to listen on";
    };
    openFirewall = lib.mkEnableOption "Open to port through the firewall";
    
  };

  config = lib.mkIf cfg.enable {
    systemd.services.hello = {
      description = "Friendly GNU-Hello as a Service Daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = ''${pkgs.socat}/bin/socat \
        TCP4-LISTEN:${builtins.toString cfg.port},reuseaddr,fork \
        EXEC:${pkgs.hello}/bin/hello
      '';
    };


    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [cfg.port];
    };
    
  };
}
