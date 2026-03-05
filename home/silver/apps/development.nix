{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Editor
    vscode # Visual Studio Code (unfree)

    # Python tooling
    python3
    uv # Fast Python package/project manager (replaces pip/venv/poetry)

    # JavaScript / Node.js
    bun      # All-in-one JS runtime, bundler and package manager
    nodejs   # Node.js LTS (use `nix shell nixpkgs#nodejs_XX` for other versions)
    fnm      # Fast Node Manager – drop-in nvm replacement that works with Nix

    # GitHub tooling
    github-desktop # GitHub Desktop GUI client (unfree)
  ];

  # Git identity – fill in your details before first use
  programs.git = {
    enable = true;
    userName = "silver";
    userEmail = "your@email.com"; # TODO: replace with your actual email address
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
