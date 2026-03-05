{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''
      # fnm (Fast Node Manager) – manages Node.js versions, nvm-compatible
      if command -v fnm &>/dev/null; then
        eval "$(fnm env --use-on-cd --shell bash)"
      fi
    '';
  };
}
