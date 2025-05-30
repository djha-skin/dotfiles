{ config, pkgs, ... }:
{
  home.username = "skin";
  home.homeDirectory = "/home/skin";
  home.file = {
    ".config/mimeapps.list".source = dotfiles/dot-config/work-mimeapps.list;
    ".config/mimeapps.list".force = true;
  };
}
