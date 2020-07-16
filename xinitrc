# vim: ft=sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

WM="$2"           # choose which window manager to use
setxkbmap gb      # tell the keyboard to use a GB keymap
eval $(ssh-agent) # start the ssh agent

# sort out issues with JVM apps assuming a reparenting WM
wmname LG3D                           
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

~/.fehbg                        # set the background 
slstatus 2>/dev/null &          # run the statusbar
dunst 2>/dev/null &             # run the notificaion manager
exec /usr/local/bin/dwm         # default to running installed version of DWM
