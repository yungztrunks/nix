{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "yungztrunks"; # change if you want
        email = "silvanbelten@example.com";
      };

      init.defaultBranch = "main";

      pull.rebase = false;

      core = {
        editor = "nano";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
  ];
}
