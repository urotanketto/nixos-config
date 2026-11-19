{ config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # init.lua is managed in the nixos-config repository.
    sideloadInitLua = true;

    withRuby = false;
    withPython3 = false;
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixos-config/home/urotanketto/nvim";
}

