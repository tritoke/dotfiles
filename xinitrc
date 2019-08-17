WM="$2"
setxkbmap gb                          # tell the keyboard to use a GB keymap
eval $(ssh-agent)                     # start the ssh agent
if [ "$WM" = kde ]
then
  exec startkde
else
  ~/.fehbg                              # set the background 
  xautolock -locker slock -time 11 &    # auto lock the screen after 11 minutes - 1 minute after screen blacks
  slstatus 2>/dev/null &                # run the statusbar
  exec dwm                              # run the window manager
fi
