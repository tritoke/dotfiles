setxkbmap gb                        	# tell the keyboard to use a GB keymap
~/.fehbg                              # set the background 
wm='dwm'
case $wm in
  dwm )
    xautolock -locker slock -time 11 &    # auto lock the screen after 11 minutes - 1 minute after screen blacks
    slstatus 2>/dev/null &                # run the statusbar
    exec dwm  ;;                          # run the window manager
esac
