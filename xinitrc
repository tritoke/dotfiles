# vim: ft=sh
setup_screens() {
  direction="$1"
  primary=$(xrandr | pcregrep -o1 '(\S+) connected primary')
  screens=$(xrandr | pcregrep -o1 '(\S+) connected (^primary)')
  for screen in $screens
  do
    case $direction in
      left   ) directionarg='--left-of'  ;;
      right  ) directionarg='--right-of' ;;
      above  ) directionarg='--above'    ;;
      below  ) directionarg='--below'    ;;
      mirror ) directionarg='--same-as'  ;;
      *      ) directionarg='--same-as'  ;;
    esac

    xrandr --output HDMI2 --auto $directionarg eDP1
    xrandr --output $screen --primary
    break
  done
}

start_dwm() {
  dwm="$1"
  # sort out issues with JVM apps assuming a reparenting WM
  wmname LG3D                           
  export AWT_TOOLKIT=MToolkit

  ~/.fehbg                        # set the background 
  slstatus 2>/dev/null &          # run the statusbar
  dunst 2>/dev/null &             # run the notificaion manager
  exec ${dwm:-/usr/local/bin/dwm} # default to running installed version of DWM
}

WM="$2"           # choose which window manager to use
setxkbmap gb      # tell the keyboard to use a GB keymap
eval $(ssh-agent) # start the ssh agent

case $WM in
  'testing' ) # start the most recently made version of DWM
    start_dwm $HOME/.builds/dwm/dwm
  ;;
  * ) # start default WM - DWM
    setup_screens "right"
    start_dwm
  ;;
esac
