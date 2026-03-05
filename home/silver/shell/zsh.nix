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

    initExtra = ''
      # fnm (Fast Node Manager) – manages Node.js versions, nvm-compatible
      if command -v fnm &>/dev/null; then
        eval "$(fnm env --use-on-cd --shell zsh)"
      fi
    '';
  };
}
