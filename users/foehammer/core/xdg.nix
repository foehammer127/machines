{...}: {
  home.file.".config/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/xdg/desktop"
    XDG_DOCUMENTS_DIR="$HOME/xdg/documents"
    XDG_DOWNLOAD_DIR="$HOME/xdg/downloads"
    XDG_MUSIC_DIR="$HOME/xdg/music"
    XDG_PICTURES_DIR="$HOME/xdg/pictures"
    XDG_TEMPLATES_DIR="$HOME/xdg/templates"
    XDG_VIDEOS_DIR="$HOME/xdg/videos"
    XDG_PUBLICSHARE_DIR="$HOME/xdg/public"
  '';

  home.file.".config/user-dirs.conf".text = ''
    enabled=False
  '';
}
