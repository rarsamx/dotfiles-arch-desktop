# Defined in - @ line 1
function pacclean --wraps='sudo pacman -Sc;sudo pacman -Rsn (sudo pacman -Qdtq)' --description 'alias pacclean=sudo pacman -Sc;sudo pacman -Rsn (sudo pacman -Qdtq)'

  echo "sudo pacman -Sc;sudo pacman -Rsn (sudo pacman -Qdtq)" $argv;
  sudo pacman -Sc;sudo pacman -Rsn (sudo pacman -Qdtq) $argv;
  echo "sudo btrfs balance start -dusage=90 /"
  sudo btrfs balance start -dusage=90 /
end
