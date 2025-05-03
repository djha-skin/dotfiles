{ config, pkgs, unstable, ... }:
{
  home.packages = with unstable; [
    goose-cli
  ];
}
