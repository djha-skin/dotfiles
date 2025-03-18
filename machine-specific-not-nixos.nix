{ config, pkgs, ... }:
let
  nixgl = import <nixgl> {};
in
{
  home.username = "dhaskin";
  home.homeDirectory = "/home/dhaskin";
  home.packages = [
    nixgl.auto.nixGLDefault
  ];
  home.file = {
    ".config/mimeapps.list".source = dotfiles/dot-config/work-mimeapps.list;
    ".config/mimeapps.list".force = true;
  };
}
