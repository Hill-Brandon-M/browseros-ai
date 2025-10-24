{
  config,
  pkgs,
  lib ? pkgs.lib,
  ...
}:

with lib;

let

  pname = "epilogue-playback";

  cfg = config.services.${pname};

in

{
  ###### interface
  options = {

    services.${pname} = rec {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to run ${pname}
        '';
      };
    };

  };

  ###### implementation

  config = mkIf cfg.enable {

    users.extraGroups.${pname} = { };

    users.extraUsers.${pname} = {
      description = "";
      group = "${pname}";
      # home = baseDir;
      isSystemUser = true;
      useDefaultShell = true;
    };

    environment.systemPackages = [ pkgs.${pname} ];

    systemd.services.${pname} = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.${pname}}/bin/${pname}";
        User = "${pname}";
        PermissionsStartOnly = true;
        Restart = "always";
      };
    };

  };

}