{ pkgs, ... }:

let
  syncDriveLinks = pkgs.writeShellApplication {
    name = "sync-windows-drive-links";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.findutils
    ];
    text = ''
      set -euo pipefail

      home_dir="$HOME"
      media_root="/run/media/$USER"

      shopt -s nullglob

      # Remove only links previously managed by this script.
      for link in "$home_dir"/[D-Z]:; do
        [[ -L "$link" ]] || continue
        target="$(readlink -- "$link" || true)"
        if [[ "$target" == "$media_root/"* ]]; then
          rm -f -- "$link"
        fi
      done

      mounts=()
      if [[ -d "$media_root" ]]; then
        while IFS= read -r -d $'\0' mount_path; do
          mounts+=("$mount_path")
        done < <(find "$media_root" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
      fi

      letters=({D..Z})
      index=0

      for mount_path in "''${mounts[@]}"; do
        if (( index >= ''${#letters[@]} )); then
          break
        fi

        link_path="$home_dir/''${letters[$index]}:"

        # Never replace a regular file or directory in home.
        if [[ -e "$link_path" && ! -L "$link_path" ]]; then
          index=$((index + 1))
          continue
        fi

        ln -sfn -- "$mount_path" "$link_path"
        index=$((index + 1))
      done
    '';
  };
in
{
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
    settings = {
      program_options = {
        file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
      };
    };
  };

  systemd.user.services.windows-drive-links = {
    Unit = {
      Description = "Mirror removable drives as Windows-style links in home";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${syncDriveLinks}/bin/sync-windows-drive-links";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.windows-drive-links = {
    Unit = {
      Description = "Refresh Windows-style drive links in home";
    };
    Timer = {
      OnBootSec = "5s";
      OnUnitActiveSec = "5s";
      Unit = "windows-drive-links.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}