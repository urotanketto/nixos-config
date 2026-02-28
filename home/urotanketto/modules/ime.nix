{ config, pkgs, ...}:

{
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
}

