# Start X at login

#echo $(date "+%Y-%m-%d %T")" .config.fish start" >> ~/start.log
#
#echo $(date "+%Y-%m-%d %T")" .config.fish GTK_IM_MODULE= $GTK_IM_MODULE" >> ~/start.log
#ps $PPID >> ~/start.log
if status is-login
#
#    echo $(date "+%Y-%m-%d %T")" .config.fish login configuration" >> ~/start.log
#    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#        echo $(date "+%Y-%m-%d %T")" .config.fish graphical configuration" >> ~/start.log
#        # Environment variables required for having java agree with GTK themes
#        #set -x QT_QPA_PLATFORMTHEME qt5ct:qt6ct
#        #set -x JAVA_FONTS /usr/share/fonts/TTF
#        #set -x _JAVA_AWT_WM_NONREPARENTING 1
#        #set -x _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true '-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'"
#        ##set -x JAVA_OPTIONS "'-Dawt.useSystemAAFontSettings=on'"
#        #set -x FREEPLANE_USE_UNSUPPORTED_JAVA_VERSION 1
#
#    export GTK_IM_MODULE=fcitx
#    export QT_IM_MODULE=fcitx
#    export XMODIFIERS=@im=fcitx

    # 1. Global variables that both Xmonad and Niri need
#    set -gx XMODIFIERS "@im=fcitx"
#    set -gx QT_IM_MODULE "fcitx"
#    
#    # 2. Dynamic handling of the problematic GTK variable
#    if test "$XDG_SESSION_TYPE" = "x11"
#        # When logging into Xmonad, use the legacy GTK module code path
#        set -gx GTK_IM_MODULE "fcitx"
#    else
#        # When logging into Niri (Wayland), completely erase it so 
#        # modern GTK applications talk natively to Niri's text-input protocol
#        set -e GTK_IM_MODULE
#    end

# Always keep XMODIFIERS populated so TUI tools can catch standard composition
    set -gx XMODIFIERS '@im=fcitx'
    set -gx QT_IM_MODULE  'fcitx'

    if test "$XDG_SESSION_TYPE" = "x11"
         # Pure X11 (XMonad) rules
        set -gx GTK_IM_MODULE 'fcitx'
        xset s 120 120
        xss-lock -l -- slock &
   else
         # Pure Wayland (Niri) rules
        set -e GTK_IM_MODULE # Let Qt 6 handle text natively via Wayland protocols
   end
    
#        # exec startx -- -keeptty
#        # exec niri --session
#        # exec xmonad
end
#end
