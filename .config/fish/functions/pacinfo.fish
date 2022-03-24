# Defined in - @ line 1
function pacinfo --wraps='pacman -Q --info' --description 'alias pacinfo=pacman -Q --info'
  echo "pacman -Q --info $argv"
  pacman -Q --info $argv;
end
