if status is-login

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
    
end
