{ config, pkgs, ...}:

{
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

    # Focus: Alt + h/j/k/l
    bind = ALT, h, movefocus, l
    bind = ALT, j, movefocus, d
    bind = ALT, k, movefocus, u
    bind = ALT, l, movefocus, r

    # Move window: Alt + Shift + h/j/k/l
    bind = ALT SHIFT, h, movewindow, l
    bind = ALT SHIFT, j, movewindow, d
    bind = ALT SHIFT, k, movewindow, u
    bind = ALT SHIFT, l, movewindow, r

    # Resize window: Alt + Shift + a/s/d/w
    bind = ALT SHIFT, a, resizeactive, -40 0
    bind = ALT SHIFT, d, resizeactive,  40 0
    bind = ALT SHIFT, w, resizeactive,  0 -40
    bind = ALT SHIFT, s, resizeactive,  0  40
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
}

