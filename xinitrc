# vim: ft=sh


if [ "$2" = plasma ]
then
  ssh-agent /usr/bin/startplasma-x11
else
  sleep 1
  xlayoutdisplay -p DP-4 -o DP-0 -o DP-4 -o DP-2

  setxkbmap gb      # tell the keyboard to use a GB keymap

  # sort out issues with JVM apps assuming a reparenting WM
  wmname LG3D                           
  export AWT_TOOLKIT=MToolkit
  export _JAVA_AWT_WM_NONREPARENTING=1

  # fix java font rendering
  export _JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on

  # dunst needs it
  systemctl --user import-environment DISPLAY

  ~/.fehbg                       # set the background 
  xbindkeys --poll-rc            # map side scroll to volume
  slstatus 2>/dev/null &         # run the statusbar
  xss-lock slock &               # lock on suspend

  ssh-agent /home/samleonard/.local/bin/dwm
fi 
