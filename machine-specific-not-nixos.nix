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
}
