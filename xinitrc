# vim: ft=sh

setxkbmap gb      # tell the keyboard to use a GB keymap

# sort out issues with JVM apps assuming a reparenting WM
wmname LG3D                           
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# fix java font rendering
export _JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on

# Not sure why this doesn't seem to be called :(
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh

~/.fehbg                       # set the background 
xbindkeys --poll-rc            # map side scroll to volume
slstatus 2>/dev/null &         # run the statusbar
xss-lock slock &               # lock on suspend :)

/usr/bin/ssh-agent /home/samleonard/.local/bin/dwm
