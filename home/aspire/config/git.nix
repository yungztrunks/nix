{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "weshford";
      user.email = "95880628+weshford@users.noreply.github.com";
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nano";
    };
  };
}
