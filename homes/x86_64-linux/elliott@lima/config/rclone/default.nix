{ config
, lib
, pkgs
, ...
}:

let
  mkService = remote: path: {
    Unit = {
      Description = "Mount for ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      After = [ "agenix.service" ];
      Wants = [ "agenix.service" ];
      X-SwitchMethod = "stop-start";
    };
    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      ExecStart = "${pkgs.rclone}/bin/rclone mount ${remote}:${path} ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote} --allow-other --file-perms 0777 --vfs-cache-mode writes --links";
      ExecStop = "/run/wrappers/bin/fusermount -u ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Unmount not working for FUSE without sudo
  mkMount = remote: {
    Unit = {
      Description = "Mount for ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      # After = [ "network-online.target" ];
    };
    Mount = {
      Type = "fuse.rclonefs";
      What = "${remote}:";
      Where = "${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
      Options = lib.concatStringsSep "," [ "allow_other" "file_perms=0777" "vfs-cache-mode=writes" ];
      ExecSearchPath = "/run/wrappers/bin/:${pkgs.rclone}/bin/";
    };
    Install = {
      # Since we are not using automount
      WantedBy = [ "default.target" ];
    };
  };

  # Automount units not working as user units
  # mkAutoMount = remote: {
  #   Unit = {
  #     Description = "Automount for ${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
  #     # After = [ "network-online.target" ];
  #     Before = [ "remote-fs.target" ];
  #   };
  #   Automount = {
  #     Where = "${config.xdg.userDirs.extraConfig.XDG_REMOTE_DIR}/${remote}";
  #     TimeoutIdleSec = 600;
  #   };
  #   Install = {
  #     WantedBy = [ "multi-user.target" ];
  #   };
  # };
in
{
  imports = [
    (import ./DotFiles { inherit mkService mkMount; })
    (import ./DropBox { inherit mkService mkMount; })
    (import ./Google { inherit mkService mkMount; })
    (import ./OneDrive { inherit mkService mkMount; })
    (import ./Work { inherit mkService mkMount; })
  ];

  home.packages = with pkgs; [
    rclone
  ];

  xdg.configFile."rclone/rclone.conf".force = true;
}
