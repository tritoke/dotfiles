xrandr --output HDMI2 --auto --right-of eDP1

WM="$2"
setxkbmap gb                              # tell the keyboard to use a GB keymap
eval $(ssh-agent)                         # start the ssh agent

case $WM in
  'xfce' ) exec startxfce4 ;;
  'kde'  ) startkde ;;
  * ) # start default WM - DWM
    ~/.fehbg                              # set the background 
    slstatus 2>/dev/null &                # run the statusbar
    exec dwm                              # run the window manager
  ;;
esac
