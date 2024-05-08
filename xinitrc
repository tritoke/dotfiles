# vim: ft=sh

DP1=$(xrandr | grep -E 'DP-([0-9])-1 connected' | cut -d' ' -f1)
DP2=$(xrandr | grep -E 'DP-([0-9])-2 connected' | cut -d' ' -f1)
xlayoutdisplay -p "$DP1" -o "$DP2" -o "$DP1"
setxkbmap -option ctrl:nocaps gb

# sort out issues with JVM apps assuming a reparenting WM
wmname LG3D                           
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# fix java font rendering
export _JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on

~/.fehbg                       # set the background 
slstatus 2>/dev/null &         # run the statusbar
xss-lock slock &               # autolocker
xbindkeys --poll-rc            # map side scroll to volume

# needed by dunst
systemctl --user import-environment DISPLAY

ssh-agent /usr/local/bin/dwm
