# Defined in /tmp/fish.Zl49pJ/pacinst.fish @ line 2
function pacinst -w 'sudo pacman -S --needed' -d 'pacman with my preferred defaults'
    echo "sudo pacman -S --needed" $argv 
    sudo pacman -S --needed $argv
end
