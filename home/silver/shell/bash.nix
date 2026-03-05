{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ll    = "ls -lahF --color=auto";
      ".."  = "cd ..";
      "..." = "cd ../..";
      # NixOS rebuild shortcuts
      update  = "sudo nixos-rebuild switch --flake ~/.config/nixos#desktop";
      upgrade = "sudo nix flake update && sudo nixos-rebuild switch --flake ~/.config/nixos#desktop";
    };

    initExtra = ''
      # fnm (Fast Node Manager) – manages Node.js versions, nvm-compatible
      if command -v fnm &>/dev/null; then
        eval "$(fnm env --use-on-cd --shell bash)"
      fi
    '';
  };
}
