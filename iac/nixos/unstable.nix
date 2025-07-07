{ config, pkgs, unstable, ... }:
{
  home.packages = [
    unstable.goose-cli
  ];
}
