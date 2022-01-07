#!/bin/sh
# [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

# merge in defaults and keymaps

[[ -f $sysresources ]] && xrdb -merge $sysresources

[[ -f $sysmodmap ]] && xmodmap $sysmodmap

[[ -f "$userresources" ]] && xrdb -merge "$userresources"

[[ -f "$usermodmap" ]] && xmodmap "$usermodmap"

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Environment variables required for having java agree with GTK themes
export QT_QPA_PLATFORMTHEME=qt5ct
export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
#export JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export FREEPLANE_USE_UNSUPPORTED_JAVA_VERSION=1

# Environment variables for fcitx
export GTK_IM_MODULE=fcitx
export tQT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

fcitx-autostart

# Load configuration for the nnn file manager.
# moved content to .pam_environment
#[[ -f ~/.config/nnn/nnnrc ]] && . ~/.config/nnn/nnnrc

# Execute the background image changer
[[ -f ~/bin/wmNitrogenBkgrndChanger ]] && . ~/bin/wmNitrogenBkgrndChanger &

# WIthout this line we may not have a cursor when starting monad
xsetroot -cursor_name left_ptr

# xsettingsd is used to provide xsettings specifications to java applications
xsettingsd &

# Light compositor. I use it so xmonad treeselect can have transparency
xcompmgr -cCn &

# Sets the colour temperature of the screen according to time
redshift &

# Tiling window manager
exec xmonad
