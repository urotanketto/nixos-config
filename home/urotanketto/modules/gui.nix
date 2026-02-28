{ config, pkgs, ...}:

{
  home.packages = with pkgs; [
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

