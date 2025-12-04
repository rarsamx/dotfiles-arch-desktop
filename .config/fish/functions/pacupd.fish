function pacupd -w 'sudo pacman -Syu' -d 'Pacman update with my preferred defaults'
    
    set numUpd (checkupdates | wc -l)
    if test $numUpd -gt 0
        echo "sudo pacman -Syu" $argv 
        sudo pacman -Syu $argv
        if test $status -eq 0
            echo "xmonad --recompile; xmonad --restart"
            xmonad --recompile; xmonad --restart
            read -n1 -P "Update finished. Press Enter to continue"
        else
            read -n1 -P "Error updating. Press Enter to continue"
        end
    else
        read -n1 -P "System is up to date. Press Enter to continue"
    end
end
