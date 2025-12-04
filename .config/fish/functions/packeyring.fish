function packeyring --wraps='=sudo pacman -Sy archlinux-keyring' --wraps='sudo pacman -Sy archlinux-keyring' --description 'alias packeyring sudo pacman -Sy archlinux-keyring'
  sudo pacman -Sy archlinux-keyring $argv; 
end
