{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    spotify # Music streaming (unfree)
  ];
}
