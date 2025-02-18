{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "skin";
  home.homeDirectory = "/home/skin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # basic
    waybar
    coreutils
    btop
    kitty
    keepassxc
    git-credential-keepassxc
    onedrive
    onedrivegui
    firefox
    glib

    # dev
    neovim
    git
    tmux
    gnupg
    gh

    # mail, chat
    neomutt
    msmtp
    offlineimap
    roswell
    irssi
    newsboat

    
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # dark/light
    ".profile".source = dotfiles/dot-profile-nix;
    ".config/sway/light_mode.conf".source = dotfiles/dot-config/sway/light_mode.conf;
    ".config/sway/dark_mode.conf".source = dotfiles/dot-config/sway/dark_mode.conf;
    ".config/kitty/tango-light.conf".source = dotfiles/dot-config/kitty/tango-light.conf;
    ".config/kitty/tango-dark.conf".source = dotfiles/dot-config/kitty/tango-dark.conf;
    ".config/waybar/styles/dark.css".source = dotfiles/dot-config/waybar/styles/dark.css;
    ".config/waybar/styles/light.css".source = dotfiles/dot-config/waybar/styles/light.css;
  
    ".screenrc".source = dotfiles/dot-screenrc;
    ".gnupg/sshcontrol".source = dotfiles/dot-gnupg/sshcontrol;
    ".gnupg/gpg-agent.conf".source = dotfiles/dot-gnupg/gpg-agent.conf;
    ".gnupg/gpg.conf".source = dotfiles/dot-gnupg/gpg.conf;
    ".purple/prefs.xml".source = dotfiles/dot-purple/prefs.xml;
    ".purple/status.xml".source = dotfiles/dot-purple/status.xml;
    ".purple/gtkrc-2.0".source = dotfiles/dot-purple/gtkrc-2.0;
    ".purple/blist.xml".source = dotfiles/dot-purple/blist.xml;
    ".msmtprc".source = dotfiles/dot-msmtprc;
    ".tool-versions".source = dotfiles/dot-tool-versions;
    ".zshrc".source = dotfiles/dot-zshrc;
    ".racket/.plt-autosave-toc-save".source = dotfiles/dot-racket/.plt-autosave-toc-save;
    ".racket/racket-prefs.rktd".source = dotfiles/dot-racket/racket-prefs.rktd;
    ".racket/.plt-autosave-toc".source = dotfiles/dot-racket/.plt-autosave-toc;
    ".roswell/init.lisp".source = dotfiles/dot-roswell/init.lisp;
    ".notmuch-config".source = dotfiles/dot-notmuch-config;
    "Mail/migadu/.notmuch-config".source = dotfiles/Mail/migadu/dot-notmuch-config;
    "Mail/home/.notmuch-config".source = dotfiles/Mail/home/dot-notmuch-config;
    ".config/environment.d/ssh_auth_socket.conf".source = dotfiles/dot-config/environment.d/ssh_auth_socket.conf;
    ".config/iamb/config.toml".source = dotfiles/dot-config/iamb/config.toml;
    ".config/common-lisp/source-registry.conf.d/50-djha-skin-lisp.conf".source = dotfiles/dot-config/common-lisp/source-registry.conf.d/50-djha-skin-lisp.conf;
    ".config/common-lisp/source-registry.conf.d/50-skin-lisp.conf".source = dotfiles/dot-config/common-lisp/source-registry.conf.d/50-skin-lisp.conf;
    ".config/common-lisp/edi-weitz".source = dotfiles/dot-config/common-lisp/edi-weitz;
    ".config/sway/status.sh".source = dotfiles/dot-config/sway/status.sh;
    ".config/sway/config".source = dotfiles/dot-config/sway/config;
    ".config/sway/experimental".source = dotfiles/dot-config/sway/experimental;
    ".config/sway/private-config".source = dotfiles/dot-config/sway/private-config;
    ".config/discordo/config.toml".source = dotfiles/dot-config/discordo/config.toml;
    ".config/sc-im/scimrc".source = dotfiles/dot-config/sc-im/scimrc;
    ".config/kitty/kitty.conf".source = dotfiles/dot-config/kitty/kitty.conf;
    ".config/qterminal.org/qterminal.ini".source = dotfiles/dot-config/qterminal.org/qterminal.ini;
    ".config/khard/khard.conf".source = dotfiles/dot-config/khard/khard.conf;
    ".config/swappy/config".source = dotfiles/dot-config/swappy/config;
    ".config/tmux/tmux.conf".source = dotfiles/dot-config/tmux/tmux.conf;
    ".config/foot/foot.ini".source = dotfiles/dot-config/foot/foot.ini;
    ".config/foot/tango".source = dotfiles/dot-config/foot/tango;
    ".config/foot/xterm".source = dotfiles/dot-config/foot/xterm;
    ".config/foot/a".source = dotfiles/dot-config/foot/a;
    ".config/nvim/colors/simple.vim".source = dotfiles/dot-config/nvim/colors/simple.vim;
    ".config/nvim/colors/rainbow_brite.vim".source = dotfiles/dot-config/nvim/colors/rainbow_brite.vim;
    ".config/nvim/autoload/cljstyle.vim".source = dotfiles/dot-config/nvim/autoload/cljstyle.vim;
    ".config/nvim/autoload/plug.vim".source = dotfiles/dot-config/nvim/autoload/plug.vim;
    ".config/nvim/init.vim".source = dotfiles/dot-config/nvim/init.vim;
    ".config/nvim/dark-mode.vim".source = dotfiles/dot-config/nvim/dark-mode.vim;
    ".config/nvim/light-mode.vim".source = dotfiles/dot-config/nvim/light-mode.vim;
    ".config/nvim/ginit.vim".source = dotfiles/dot-config/nvim/ginit.vim;
    ".config/wayfire.ini".source = dotfiles/dot-config/wayfire.ini;
    ".config/waybar/config".source = dotfiles/dot-config/waybar/config;
    ".config/waybar/convert_colors.py".source = dotfiles/dot-config/waybar/convert_colors.py;
    ".config/zoomus.conf".source = dotfiles/dot-config/zoomus.conf;
    ".config/mimeapps.list".source = dotfiles/dot-config/mimeapps.list;
    ".config/autostart/set-input-settings.desktop".source = dotfiles/dot-config/autostart/set-input-settings.desktop;
    ".config/autostart/keynav.desktop".source = dotfiles/dot-config/autostart/keynav.desktop;
    ".config/clpm/clpm.conf".source = dotfiles/dot-config/clpm/clpm.conf;
    ".config/clpm/sources.conf".source = dotfiles/dot-config/clpm/sources.conf;
    ".config/nchat/ui.conf".source = dotfiles/dot-config/nchat/ui.conf;
    ".config/spotifyd/spotifyd.conf".source = dotfiles/dot-config/spotifyd/spotifyd.conf;
    ".config/qutebrowser/bookmarks/urls".source = dotfiles/dot-config/qutebrowser/bookmarks/urls;
    ".config/qutebrowser/config.py".source = dotfiles/dot-config/qutebrowser/config.py;
    ".config/qutebrowser/autoconfig.yml".source = dotfiles/dot-config/qutebrowser/autoconfig.yml;
    ".config/systemd/user/onedrive-sync.service".source = dotfiles/dot-config/systemd/user/onedrive-sync.service;
    ".config/systemd/user/comodoro.service".source = dotfiles/dot-config/systemd/user/comodoro.service;
    ".config/systemd/user/himalaya-notify-gmail.service".source = dotfiles/dot-config/systemd/user/himalaya-notify-gmail.service;
    ".config/systemd/user/home-skin-WorkGoogleDrive.mount".source = dotfiles/dot-config/systemd/user/home-skin-WorkGoogleDrive.mount;
    ".config/systemd/user/himalaya-notify-skin.service".source = dotfiles/dot-config/systemd/user/himalaya-notify-skin.service;
    ".config/systemd/user/mbsync.timer".source = dotfiles/dot-config/systemd/user/mbsync.timer;
    ".config/systemd/user/librespot.service".source = dotfiles/dot-config/systemd/user/librespot.service;
    ".config/systemd/user/pidgin.service".source = dotfiles/dot-config/systemd/user/pidgin.service;
    ".config/systemd/user/spotifyd.service".source = dotfiles/dot-config/systemd/user/spotifyd.service;
    ".config/systemd/user/himalaya-watch-skin.service".source = dotfiles/dot-config/systemd/user/himalaya-watch-skin.service;
    ".config/systemd/user/sync-mail.service".source = dotfiles/dot-config/systemd/user/sync-mail.service;
    ".config/systemd/user/mbsync.service".source = dotfiles/dot-config/systemd/user/mbsync.service;
    ".config/systemd/user/home-skin-HomeGoogleDrive.mount".source = dotfiles/dot-config/systemd/user/home-skin-HomeGoogleDrive.mount;
    ".config/systemd/user/himalaya-watch-gmail.service".source = dotfiles/dot-config/systemd/user/himalaya-watch-gmail.service;
    ".config/systemd/user/sync-mail.timer".source = dotfiles/dot-config/systemd/user/sync-mail.timer;
    ".config/systemd/user/onedrive-sync.timer".source = dotfiles/dot-config/systemd/user/onedrive-sync.timer;
    ".config/alacritty/alacritty.toml".source = dotfiles/dot-config/alacritty/alacritty.toml;
    ".config/fontconfig/conf.d/01-font.conf".source = dotfiles/dot-config/fontconfig/conf.d/01-font.conf;
    ".config/gtk-3.0/settings.ini".source = dotfiles/dot-config/gtk-3.0/settings.ini;
    ".mbsyncrc".source = dotfiles/dot-mbsyncrc;
    ".inputrc".source = dotfiles/dot-inputrc;
    ".vimrc".source = dotfiles/dot-vimrc;
    ".emacs".source = dotfiles/dot-emacs;
    ".ratpoisonrc".source = dotfiles/dot-ratpoisonrc;
    ".newsboat/urls".source = dotfiles/dot-newsboat/urls;
    ".newsboat/config".source = dotfiles/dot-newsboat/config;
    ".gtkrc-2.0".source = dotfiles/dot-gtkrc-2.0;
    ".mutt/mmigadu.account".source = dotfiles/dot-mutt/mmigadu.account;
    ".mutt/mhome.account".source = dotfiles/dot-mutt/mhome.account;
    ".mutt/simple.muttrc".source = dotfiles/dot-mutt/simple.muttrc;
    ".mutt/dracula.muttrc".source = dotfiles/dot-mutt/dracula.muttrc;
    ".mutt/migadu.account".source = dotfiles/dot-mutt/migadu.account;
    ".mutt/home.account".source = dotfiles/dot-mutt/home.account;
    ".racketrc".source = dotfiles/dot-racketrc;
    ".ratpoisonmouse".source = dotfiles/dot-ratpoisonmouse;
    ".offlineimaprc".source = dotfiles/dot-offlineimaprc;
    ".muttrc".source = dotfiles/dot-muttrc;
    ".tridactylrc".source = dotfiles/dot-tridactylrc;
    ".mailcap".source = dotfiles/dot-mailcap;
    ".nanorc".source = dotfiles/dot-nanorc;
    ".shell_aliases".source = dotfiles/dot-shell_aliases;
    ".Xresources".source = dotfiles/dot-Xresources;
    ".lein/profiles.clj".source = dotfiles/dot-lein/profiles.clj;
    ".urlview".source = dotfiles/dot-urlview;
    ".offlineimap.py".source = dotfiles/dot-offlineimap.py;
    ".bashrc".source = dotfiles/dot-bashrc;
    ".Xdefaults".source = dotfiles/dot-Xdefaults;
    ".emacs.d/themes/djhaskin987-midnight-theme.el".source = dotfiles/dot-emacs.d/themes/djhaskin987-midnight-theme.el;
    ".emacs.d/lisp/color-theme-rainbow-brite.el".source = dotfiles/dot-emacs.d/lisp/color-theme-rainbow-brite.el;
    ".emacs.d/lisp/xterm-extras.el".source = dotfiles/dot-emacs.d/lisp/xterm-extras.el;
    ".emacs.d/lisp/linum+.el".source = dotfiles/dot-emacs.d/lisp/linum+.el;
    ".emacs.d/lisp/djhaskin987-untab-to-tab-stop.el".source = dotfiles/dot-emacs.d/lisp/djhaskin987-untab-to-tab-stop.el;
    ".emacs.d/lisp/color-theme-djhaskin987-console.el".source = dotfiles/dot-emacs.d/lisp/color-theme-djhaskin987-console.el;
    ".emacs.d/eshell/alias".source = dotfiles/dot-emacs.d/eshell/alias;
    ".emacs.d/.emacs.d/themes/djhaskin987-midnight-theme.el".source = dotfiles/dot-emacs.d/.emacs.d/themes/djhaskin987-midnight-theme.el;
    ".emacs.d/.emacs.d/lisp/color-theme-rainbow-brite.el".source = dotfiles/dot-emacs.d/.emacs.d/lisp/color-theme-rainbow-brite.el;
    ".emacs.d/.emacs.d/lisp/color-theme-djha-skin-console.el".source = dotfiles/dot-emacs.d/.emacs.d/lisp/color-theme-djha-skin-console.el;
    ".emacs.d/.emacs.d/lisp/xterm-extras.el".source = dotfiles/dot-emacs.d/.emacs.d/lisp/xterm-extras.el;
    ".emacs.d/.emacs.d/lisp/linum+.el".source = dotfiles/dot-emacs.d/.emacs.d/lisp/linum+.el;
    ".emacs.d/.emacs.d/lisp/djha-skin-untab-to-tab-stop.el".source = dotfiles/dot-emacs.d/.emacs.d/lisp/djha-skin-untab-to-tab-stop.el;
    ".emacs.d/.emacs.d/eshell/alias".source = dotfiles/dot-emacs.d/.emacs.d/eshell/alias;
    ".ratpoisonkeys".source = dotfiles/dot-ratpoisonkeys;
    ".gtkrc-2.0-kde4".source = dotfiles/dot-gtkrc-2.0-kde4;
    ".gcalclirc".source = dotfiles/dot-gcalclirc;
    ".local/share/figlet/djhaskin.flf".source = dotfiles/dot-local/share/figlet/djhaskin.flf;
    #".local/share/applications/urn-handler.desktop".source = dotfiles/dot-local/share/applications/urn-handler.desktop;
    #".local/share/applications/st-256color.desktop".source = dotfiles/dot-local/share/applications/st-256color.desktop;
    #".local/share/applications/OneDriveGUI.desktop".source = dotfiles/dot-local/share/applications/OneDriveGUI.desktop;
    ".local/share/qutebrowser/userscripts/qute-keepassxc".source = dotfiles/dot-local/share/qutebrowser/userscripts/qute-keepassxc;
    ".local/bin/copy".source = dotfiles/dot-local/bin/copy;
    ".local/bin/stylus-back".source = dotfiles/dot-local/bin/stylus-back;
    ".local/bin/dropbox-sync".source = dotfiles/dot-local/bin/dropbox-sync;
    ".local/bin/start-my-day".source = dotfiles/dot-local/bin/start-my-day;
    ".local/bin/get-message-id".source = dotfiles/dot-local/bin/get-message-id;
    ".local/bin/qp".source = dotfiles/dot-local/bin/qp;
    ".local/bin/com-run".source = dotfiles/dot-local/bin/com-run;
    ".local/bin/light-mode".source = dotfiles/dot-local/bin/light-mode;
    ".local/bin/choose-file".source = dotfiles/dot-local/bin/choose-file;
    ".local/bin/start-sway-process".source = dotfiles/dot-local/bin/start-sway-process;
    ".local/bin/testtruecolor".source = dotfiles/dot-local/bin/testtruecolor;
    ".local/bin/him".source = dotfiles/dot-local/bin/him;
    ".local/bin/file2gdrive".source = dotfiles/dot-local/bin/file2gdrive;
    ".local/bin/point".source = dotfiles/dot-local/bin/point;
    ".local/bin/sync-mail".source = dotfiles/dot-local/bin/sync-mail;
    ".local/bin/calc-lesson".source = dotfiles/dot-local/bin/calc-lesson;
    ".local/bin/screen2slack".source = dotfiles/dot-local/bin/screen2slack;
    ".local/bin/notify-bell".source = dotfiles/dot-local/bin/notify-bell;
    ".local/bin/onedrive-sync".source = dotfiles/dot-local/bin/onedrive-sync;
    ".local/bin/open-urn".source = dotfiles/dot-local/bin/open-urn;
    ".local/bin/screenshot-region".source = dotfiles/dot-local/bin/screenshot-region;
    ".local/bin/screen2gdrive".source = dotfiles/dot-local/bin/screen2gdrive;
    ".local/bin/file2vim".source = dotfiles/dot-local/bin/file2vim;
    ".local/bin/timer".source = dotfiles/dot-local/bin/timer;
    ".local/bin/pidgin-notify".source = dotfiles/dot-local/bin/pidgin-notify;
    ".local/bin/markdown-to-pdf".source = dotfiles/dot-local/bin/markdown-to-pdf;
    ".local/bin/paste".source = dotfiles/dot-local/bin/paste;
    ".local/bin/multipass".source = dotfiles/dot-local/bin/multipass;
    ".local/bin/dropbox-down".source = dotfiles/dot-local/bin/dropbox-down;
    ".local/bin/markdown-to-html".source = dotfiles/dot-local/bin/markdown-to-html;
    ".local/bin/set-input-settings".source = dotfiles/dot-local/bin/set-input-settings;
    ".local/bin/sync-gmail".source = dotfiles/dot-local/bin/sync-gmail;
    ".local/bin/clip2gist".source = dotfiles/dot-local/bin/clip2gist;
    ".local/bin/dropbox-up".source = dotfiles/dot-local/bin/dropbox-up;
    ".local/bin/patch-system".source = dotfiles/dot-local/bin/patch-system;
    ".local/bin/entry".source = dotfiles/dot-local/bin/entry;
    ".local/bin/swank-repl".source = dotfiles/dot-local/bin/swank-repl;
    ".local/bin/one-at-a-time".source = dotfiles/dot-local/bin/one-at-a-time;
    ".local/bin/dpi-fix".source = dotfiles/dot-local/bin/dpi-fix;
    ".local/bin/himalaya-mbox".source = dotfiles/dot-local/bin/himalaya-mbox;
    ".local/bin/diary".source = dotfiles/dot-local/bin/diary;
    ".local/bin/consume-clipboard".source = dotfiles/dot-local/bin/consume-clipboard;
    ".local/bin/dark-mode".source = dotfiles/dot-local/bin/dark-mode;
    ".local/bin/dropbox-start".source = dotfiles/dot-local/bin/dropbox-start;
    ".local/bin/rotate".source = dotfiles/dot-local/bin/rotate;
    ".local/bin/login-to-discord".source = dotfiles/dot-local/bin/login-to-discord;
    ".local/bin/wdh.py".source = dotfiles/dot-local/bin/wdh.py;
    ".local/bin/com".source = dotfiles/dot-local/bin/com;
    ".local/bin/khal-remind".source = dotfiles/dot-local/bin/khal-remind;
    ".local/bin/work-file2gdrive".source = dotfiles/dot-local/bin/work-file2gdrive;
    ".local/bin/vim-screenshot".source = dotfiles/dot-local/bin/vim-screenshot;
    ".local/bin/gcal".source = dotfiles/dot-local/bin/gcal;
    ".local/bin/clrepl".source = dotfiles/dot-local/bin/clrepl;
    ".local/bin/scalemon".source = dotfiles/dot-local/bin/scalemon;
    ".local/bin/croncal".source = dotfiles/dot-local/bin/croncal;
    ".local/bin/screen2vim".source = dotfiles/dot-local/bin/screen2vim;
    ".local/bin/kpuser".source = dotfiles/dot-local/bin/kpuser;
    ".local/bin/notify".source = dotfiles/dot-local/bin/notify;
    ".local/bin/display-calendar".source = dotfiles/dot-local/bin/display-calendar;
    ".local/bin/stylus-left".source = dotfiles/dot-local/bin/stylus-left;
    ".local/bin/work-screen2gdrive".source = dotfiles/dot-local/bin/work-screen2gdrive;
    ".local/bin/gdfuse".source = dotfiles/dot-local/bin/gdfuse;
    ".local/bin/file2rclone".source = dotfiles/dot-local/bin/file2rclone;
    ".local/bin/pidge".source = dotfiles/dot-local/bin/pidge;
    ".local/bin/com-hook".source = dotfiles/dot-local/bin/com-hook;
    ".local/bin/kptotp".source = dotfiles/dot-local/bin/kptotp;
    ".local/bin/pasta".source = dotfiles/dot-local/bin/pasta;
    ".local/bin/himctl".source = dotfiles/dot-local/bin/himctl;
    ".local/bin/hmbox".source = dotfiles/dot-local/bin/hmbox;
    ".local/bin/screen2rclone".source = dotfiles/dot-local/bin/screen2rclone;
    ".local/bin/bamboohr-to-vcards.py".source = dotfiles/dot-local/bin/bamboohr-to-vcards.py;
    ".local/lib/no-tables.lua".source = dotfiles/dot-local/lib/no-tables.lua;
    ".local/lib/add-message-id.py".source = dotfiles/dot-local/lib/add-message-id.py;
    ".local/lib/copy-pasta.sh".source = dotfiles/dot-local/lib/copy-pasta.sh;
    ".Xmodmap".source = dotfiles/dot-Xmodmap;
    ".ssh/config".source = dotfiles/dot-ssh/config;
    ".gitconfig".source = dotfiles/dot-gitconfig;
    ".sbclrc".source = dotfiles/dot-sbclrc;
    




    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/skin/etc/profile.d/hm-session-vars.sh
  #
  #home.sessionVariables = {
  #};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
