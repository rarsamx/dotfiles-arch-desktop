#!/bin/sh
# [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

fcitx-autostart

# Load configuration for the nnn file manager.
[[ -f ~/.config/nnn/nnnrc ]] && . ~/.config/nnn/nnnrc

# Execute the background changer
[[ -f ~/bin/xmonadBackgroundChanger.sh ]] && . ~/bin/xmonadBackgroundChanger.sh &

xsetroot -cursor_name left_ptr
xsettingsd &
xcompmgr -cCn &
exec xmonad
