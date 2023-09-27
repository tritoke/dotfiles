# vim: ft=sh

xlayoutdisplay -p DP-3-1 -o DP-3-2 -o DP-3-1
setxkbmap -option ctrl:nocaps gb

# sort out issues with JVM apps assuming a reparenting WM
wmname LG3D                           
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# fix java font rendering
export _JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on

~/.fehbg                       # set the background 
slstatus 2>/dev/null &         # run the statusbar

xbindkeys --poll-rc            # map side scroll to volume
# dunst 2>/dev/null &            # run the notificaion manager

# dmenu_path doesn't have the right path sometimes
eval $(ssh-agent -s)
