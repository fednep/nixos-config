{lib, ...}: {

  xresources.properties = {
    # URXVT FONT SETTINGS"
    #------------------------------------------------"
    "Xft.dpi" = lib.mkDefault 110;

    # URxvt*font: xft:Go Mono for Powerline:size=10
    # URxvt*font: xft:Ubuntu Mono derivative Powerline:size=12
    # URxvt*font: xft:monofur for Powerline:size=12
    # URxvt*font: xft:Droid Sans Mono for Powerline:size=10
    "URxvt*font" = lib.mkDefault "xft:DejaVu Sans Mono for Powerline:size=10";

    "Xft.autohint" = true;
    "Xft.antialias" = true;
    "Xft.hinting" = true;
    "Xft.hintstyle" = "hintslight";
    "Xft.rgba" = "rgb";
    "Xft.lcdfilter" = "lcddefault";

    # TERMINAL COLORS
    #------------------------------------------------
    "*background" = "#1D1F21";
    "*foreground" = "#C5C8C6";
    "*cursorColor" = "#C3FF00";

    # black
    "*color0" = "#282A2E";
    "*color8" = "#373B41";
    # red
    "*color1" = "#A54242";
    "*color9" = "#CC6666";
    # green
    "*color2" = "#8C9440";
    "*color10" = "#B5BD68";
    # yellow
    "*color3" = "#DE935F";
    "*color11" = "#F0C674";
    # blue
    "*color4" = "#5F819D";
    "*color12" = "#81A2BE";
    # magenta
    "*color5" = "#85678F";
    "*color13" = "#B294BB";
    # cyan
    "*color6" = "#5E8D87";
    "*color14" = "#8ABEB7";
    # white
    "*color7" = "#707880";
    "*color15" = "#C5C8C6";

    # URXVT
    #----------------------------------------------------------------------
    # Colors
    # bold, italic, underline
    "URxvt.colorBD" = "#B5BD68";
    "URxvt.colorIT" = "#B294BB";
    "URxvt.colorUL" = "#81A2BE";

    "URxvt.scrollBar" = false;

    # Disable Ctrl + shift
    "URxvt.iso14755" = false;
    "URxvt.iso14755_52" = false;
  };
}
