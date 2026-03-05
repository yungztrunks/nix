{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable  = true;
      theme   = "agnoster";
      plugins = [ "git" "sudo" "docker" "python" ];
    };

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
        eval "$(fnm env --use-on-cd --shell zsh)"
      fi
    '';
  };
}
