{ config, pkgs, ... }:

{
  home.username = "urotanketto";
  home.homeDirectory = "/home/urotanketto";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "urotanketto";
        email = "197749865+urotanketto@users.noreply.github.com";
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
      color.ui = "auto";
    };

  };

  programs.zsh.enable = true;
  programs.fzf.enable = true;

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;

    extraConfig = ''
      ##### Prefix (C-q) + nested tmux (C-q C-q)
      unbind C-b
      set -g prefix C-q
      bind C-q send-prefix

      ##### Truecolor
      set -ga terminal-overrides ",*:Tc"

      ##### Split bindings
      unbind %
      unbind '"'

      bind - split-window -v -c "#{pane_current_path}"
      bind \\ split-window -h -c "#{pane_current_path}"

      ##### colorscheme (tmux)
      # bg: #161821, bg2: #1e2132, fg: #c6c8d1, blue: #84a0c6, cyan: #89b8c2, red: #e27878, green: #b4be82, yellow: #e2a478

      set -g status on
      set -g status-interval 5
      set -g status-justify left
      set -g status-style "bg=#161821,fg=#c6c8d1"

      # Pane borders
      set -g pane-border-style "fg=#3c4154"
      set -g pane-active-border-style "fg=#84a0c6"

      # Messages / mode
      set -g message-style "bg=#1e2132,fg=#c6c8d1"
      set -g mode-style "bg=#84a0c6,fg=#161821"

      # Status left/right (minimal)
      set -g status-left-length 40
      set -g status-right-length 80
      set -g status-left "#[bg=#161821,fg=#84a0c6] #S #[fg=#3c4154]|#[default]"
      set -g status-right "#[fg=#89b8c2]%Y-%m-%d #[fg=#e2a478]%H:%M #[fg=#3c4154]| #[fg=#b4be82]#H #[default]"

      # Window list
      setw -g window-status-style "bg=#161821,fg=#c6c8d1"
      setw -g window-status-current-style "bg=#1e2132,fg=#84a0c6"
      setw -g window-status-format " #I:#W "
      setw -g window-status-current-format " #I:#W "

      ##### Copy-mode (vi-like)
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim/init.lua".text = ''
    -- Basic options
    vim.g.mapleader = " "

    vim.opt.number = true
    vim.opt.signcolumn = "yes"
    -- Enable truecolor only on terminals that can handle it well
    local term = vim.env.TERM or ""
    local colorterm = vim.env.COLORTERM or ""

    if term ~= "linux" and (colorterm ~= "" or term:find("256color")) then
      vim.opt.termguicolors = true
    else
      vim.opt.termguicolors = false
    end

    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2

    vim.opt.ignorecase = true
    vim.opt.smartcase = true
  '';

  xdg.configFile."hypr/hyprland.conf".text = ''
    $mod = SUPER

    input {
      kb_options = ctrl:nocaps

      touchpad {
        natural_scroll = true
      }
    }

    monitor = eDP-1,preferred,0x0,1.25

    exec-once = mako
    exec-once = waybar
    exec-once = swaybg -c "161821"
    exec-once = fcitx5 -d

    bind = $mod, Return, exec, foot
    bind = $mod, D, exec, wofi --show drun
    bind = $mod, Q, killactive
    bind = $mod, M, exit

    bind = $mod SHIFT, S, exec, grim -g "$(slurp" ~/Pictures/screenshot-$(date +%F-%H%M%S).png
  '';

  xdg.configFile."waybar/config.jsonc".text = ''
  {
    "layer": "top",
    "position": "top",

    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["network", "pulseaudio", "battery", "tray"],

    "clock": { "format": "{:%Y-%m-%d %H:%M}" },

    "network": {
      "format-wifi": "  {signalStrength}%",
      "format-ethernet": " LAN",
      "format-disconnected": " NoNet"
    },

    "pulseaudio": { "format": " {volume}%", "format-muted": " MUTED" },

    "battery": { "format": "  {capacity}%", "format-charging": "  {capacity}%" }
  }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family:
        "Font Awesome 7 Free",
        "Font Awesome 7 Brands",
        "Noto Sans",
        "Noto Sand CJK JP",
        "Noto Color Emoji",
        sans-serif;
      font-size: 11px;
      min-height: 0;
    }

    window#waybar{
      background: rgba(22, 24, 33, 0.92);
      color: #c6c8d1;
    }

    #workspaces, #clock, #network, #pulseaudio, #battery, #tray {
      padding: 0 6px;
      margin: 0 2px;
    }
  '';

  xdg.configFile."fcitx5/profile".text = ''
  [Groups/0]
  Name=Default
  Default Layout=us
  DefaultIM=keyboard-us

  [Groups/0/Items/0]
  Name=keyboard-us
  Layout=us

  [Groups/0/Items/1]
  Name=mozc
  Layout=

  [GroupOrder]
  0=Defalut
  '';
  
  home.file.".local/bin/hypr-display-scale-menu" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      MONITOR="eDP-1"

      CHOICE="$(
        printf '%s\n' \
          "scale 1.00" \
          "scale 1.25" \
          "scale 1.50" \
          "scale 1.75" \
          "scale 2.00" \
        | wofi --dmenu --prompt "Display scale ($MONITOR)"
      )"

      [ -z "''${CHOICE:-}" ] && exit 0

      case "$CHOICE" in
        "scale 1.00")
          hyprctl keyword monitor "$MONITOR,preferred,0x0,1"
          ;;
        "scale 1.25")
          hyprctl keyword monitor "$MONITOR,preferred,0x0,1.25"
          ;;
        "scale 1.50")
          hyprctl keyword monitor "$MONITOR,preferred,0x0,1.5"
          ;;
        "scale 1.75")
          hyprctl keyword monitor "$MONITOR,preferred,0x0,1.75"
          ;;
        "scale 2.00")
          hyprctl keyword monitor "$MONITOR,preferred,0x0,2"
          ;;
      esac
    '';
    executable = true;
  };

  xdg.desktopEntries.hypr-display-scale = {
    name = "Display Scale";
    genericName = "Hyprland Display Scale Menu";
    comment = "Choose display scale presets for Hyprland";
    exec = "/home/urotanketto/.local/bin/hypr-display-scale-menu";
    terminal = false;
    categories = [ "Settings" "Utility" ];
  };

  home.packages = with pkgs; [
    ripgrep fd jq tree
    pciutils usbutils
    lsof strace htop
    dnsutils mtr traceroute ethtool
    unzip zip xz
    lm_sensors
    gh
    gcc binutils

    # --- Go ---
    go
    gopls
    gotools
    golangci-lint
    delve

    # --- Rust ---
    rustc
    cargo
    rust-analyzer
    cargo-edit
    cargo-watch

    # --- Haskell ---
    ghc
    cabal-install
    haskell-language-server
    hlint
    ormolu

    foot
    wofi
    waybar
    mako
    swaybg
    grim slurp
    wl-clipboard
    firefox
  ];
}

