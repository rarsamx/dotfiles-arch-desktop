# Defined in - @ line 1
function ll --wraps='ls -ahl' --description 'alias ll=ls -ahl'
  ls -ahl $argv;
end
