# Start X at login

#echo $(date "+%Y-%m-%d %T")" .config.fish start" >> ~/start.log
#
#echo $(date "+%Y-%m-%d %T")" .config.fish GTK_IM_MODULE= $GTK_IM_MODULE" >> ~/start.log
ps $PPID >> ~/start.log
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
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
#        # exec startx -- -keeptty
#        # exec niri --session
#        # exec xmonad
    end
#end
