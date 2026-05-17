{ pkgs, appleFontsPkgs ? null, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # JetBrains Mono Nerd Font for terminal
    (nerd-fonts.jetbrains-mono)
  ] ++ (if appleFontsPkgs != null then [
    # Apple fonts for better character rendering (CJK, special characters, etc.)
    # Using regular versions (not nerd-patched) to avoid memory issues during font patcher
    appleFontsPkgs.sf-pro
    appleFontsPkgs.sf-mono
    appleFontsPkgs.sf-compact
  ] else []);
}
