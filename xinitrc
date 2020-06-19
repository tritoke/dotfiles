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
