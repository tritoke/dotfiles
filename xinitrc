# vim: ft=sh

setxkbmap gb      # tell the keyboard to use a GB keymap

# sort out issues with JVM apps assuming a reparenting WM
wmname LG3D                           
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# fix java font rendering
export _JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on

~/.fehbg                       # set the background 
xbindkeys --poll-rc            # map side scroll to volume
slstatus 2>/dev/null &         # run the statusbar
dunst 2>/dev/null &            # run the notificaion manager
ssh-agent /usr/local/bin/dwm   # default to running installed version of DWM
