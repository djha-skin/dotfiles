
{ config, pkgs, ... }:
let
  nixgl = import <nixgl> {};
in
{
  home.username = "<whatever>";
  home.homeDirectory = "/home/<whatever>";
}
