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

  systemd.user.services.ssh-agent = {
    Unit = {
        Description = "SSH key agent";
        After = "graphical-session-pre.target";
        PartOf = "graphical-session.target";
    };

    Service = {
        Type = "simple";
        Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
        ExecStart = "/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK";
    };

    Install = {
        WantedBy = ["default.target"];
    };
  };
}
