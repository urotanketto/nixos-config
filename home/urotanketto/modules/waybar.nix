{ config, pkgs, ...}:

{
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
}

