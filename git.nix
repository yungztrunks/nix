{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "yungztrunks"; # change if you want
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
