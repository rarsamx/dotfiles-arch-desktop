function pacuninst -w 'sudo pacman -Rcns' -d 'Pacman uninstall with my preferred defaults'
    echo "sudo pacman -Rcns" $argv
    sudo pacman -Rcns $argv
end
