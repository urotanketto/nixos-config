{ config, pkgs, ...}:

{
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = { "gtk-application-prefer-dark-theme" = 1; };
    gtk4.extraConfig = { "gtk-application-prefer-dark-theme" = 1; };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

  home.packages = with pkgs; [
    foot
    wofi
    waybar
    mako
    swaybg
    grim slurp
    wl-clipboard
    cliphist
    firefox
    hyprlock
    hypridle
    polkit_gnome
  ];
}

