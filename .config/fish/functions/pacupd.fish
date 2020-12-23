function pacupd -w 'sudo pacman -Syu' -d 'Pacman update with my preferred defaults'
    echo "sudo pacman -Syu" $argv 
    sudo pacman -Syu $argv
end
