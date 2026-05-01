{ ... }:

{
  imports = [
    ./session.nix
    ./cursor.nix
    ./secrets.nix
    ./mounts.nix
    ./rclone.nix
    ./defaults.nix
  ];
}
