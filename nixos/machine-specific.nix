
{ config, pkgs, ... }:
let
  nixgl = import <nixgl> {};
in
{
  home.username = "skin";
  home.homeDirectory = "/home/skin";


  home.packages = [
    pkgs.onedrivegui
  ];

  home.file = {
    ".msmtprc".source = dotfiles/dot-msmtprc;
    ".offlineimaprc".source = dotfiles/dot-offlineimaprc;


    ".msmtprc".force = true;
    ".offlineimaprc".force = true;
  };

}


