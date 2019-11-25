xrandr --output HDMI2 --auto --right-of eDP1

WM="$2"
setxkbmap gb                              # tell the keyboard to use a GB keymap
eval $(ssh-agent)                         # start the ssh agent

case $WM in
  'xfce' ) exec startxfce4 ;;
  'kde'  ) exec startplasma-x11 ;;
  * ) # start default WM - DWM
    wmname LG3D                           # sort out issues with JVM apps assuming a reparenting WM
    ~/.fehbg                              # set the background 
    slstatus 2>/dev/null &                # run the statusbar
    exec dwm                              # run the window manager
  ;;
esac
