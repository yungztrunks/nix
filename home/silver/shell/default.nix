{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./bash.nix
    ./zsh.nix
  ];
}
