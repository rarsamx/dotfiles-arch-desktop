# Defined in - @ line 1
function ll --wraps='ls -hl' --description 'alias ll=ls -hl'
  ls -hl $argv;
end
