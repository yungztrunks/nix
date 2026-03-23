{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "weshford"; # change if you want
        email = "95880628+weshford@users.noreply.github.com";
      };

      init.defaultBranch = "main";

      pull.rebase = false;

      core = {
        editor = "nano";
      };
    };
  };
}
