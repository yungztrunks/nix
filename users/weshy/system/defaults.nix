{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
      "application/zip" = [ "org.kde.ark.desktop" ];
      "application/x-zip" = [ "org.kde.ark.desktop" ];
      "application/x-zip-compressed" = [ "org.kde.ark.desktop" ];
      "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
      "application/x-rar" = [ "org.kde.ark.desktop" ];
      "application/vnd.rar" = [ "org.kde.ark.desktop" ];
      "application/x-tar" = [ "org.kde.ark.desktop" ];
      "application/x-gtar" = [ "org.kde.ark.desktop" ];
      "application/gzip" = [ "org.kde.ark.desktop" ];
      "application/x-gzip" = [ "org.kde.ark.desktop" ];
      "application/x-bzip2" = [ "org.kde.ark.desktop" ];
      "application/x-xz" = [ "org.kde.ark.desktop" ];
      "text/plain" = [ "org.kde.kate.desktop" ];
    };
  };
}
