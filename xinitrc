# vim: ft=sh
primary=$(xrandr | pcregrep -o1 '(\S+) connected primary')
screens=$(xrandr | pcregrep -o1 '(\S+) connected (^primary)')
for screen in $screens
do
  xrandr --output $screen --auto --right-of $primary
  xrandr --output $screen --primary
  break
done

xrandr --output HDMI2 --auto --right-of eDP1

WM="$2"
setxkbmap gb                              # tell the keyboard to use a GB keymap
eval $(ssh-agent)                         # start the ssh agent

case $WM in
  'xfce' ) 
    exec startxfce4
  ;;
  'kde' )
    exec startplasma-x11
  ;;
  'testing' ) # start the most recently made version of DWM
    wmname LG3D
    ~/.fehbg
    slstatus 2>/dev/null &
    dunst 2>/dev/null &
    exec $HOME/.builds/dwm/dwm
  ;;
  * ) # start default WM - DWM
    wmname LG3D                           # sort out issues with JVM apps assuming a reparenting WM
    ~/.fehbg                              # set the background 
    slstatus 2>/dev/null &                # run the statusbar
    dunst 2>/dev/null &                   # run the notificaion manager
    exec dwm                              # run the window manager
  ;;
esac
