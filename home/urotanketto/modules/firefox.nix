{pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        # Enable Firefox's redesigned sidebar and vertical tabs.
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;

        # Keep the vertical tab sidebar visible.
        "sidebar.visibility" = "always-show";
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        vimium
      ];
    };
  };
}

