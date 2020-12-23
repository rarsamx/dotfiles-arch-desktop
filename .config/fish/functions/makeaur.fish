function makeaur -w 'makepkg -scir --needed' -d 'Makes an AUR package with default options'
    echo "makepkg -scir --needed"
    makepkg -scir --needed $argv
end
