{ ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;

    extraConfig = builtins.readFile ../tmux/tmux.conf;
  };
}

