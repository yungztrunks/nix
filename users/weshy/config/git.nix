{ userConfig, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = userConfig.gitName or userConfig.username;
      user.email = userConfig.gitEmail or "user@example.com";
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nano";
    };
  };
}
