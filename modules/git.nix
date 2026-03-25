{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "yungztrunks";
        email = "95880628+yungztrunks@users.noreply.github.com";
      };

      init.defaultBranch = "main";

      pull.rebase = false;

      core = {
        editor = "nano";
      };
    };
  };
}
