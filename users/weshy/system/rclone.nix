{ config, pkgs, ... }:

let
  homeDir = config.home.homeDirectory;
  rcloneConfig = "${homeDir}/.config/rclone/rclone.conf";
  mountPoint = "${homeDir}/D:";
  passFile = config.sops.secrets."rclone/archived_dav_pass".path;
in
{
  home.packages = [
    pkgs.rclone
    pkgs.fuse3
  ];

  systemd.user.services.rclone-mount-d = {
    Unit = {
      Description = "archived-sync";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "simple";
      Environment = [ "RCLONE_CONFIG=${rcloneConfig}" ];
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -p ${mountPoint}"
        "${pkgs.bash}/bin/bash -c '${pkgs.rclone}/bin/rclone config create archived-dav webdav url=http://192.168.2.229:3923 vendor=owncloud pacer_min_sleep=0.01ms user=k pass=\"$(cat ${passFile})\"'"
      ];
      ExecStart = "${pkgs.rclone}/bin/rclone mount archived-dav: ${mountPoint} --vfs-cache-mode writes --dir-cache-time 5s";
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u ${mountPoint}";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
