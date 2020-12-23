# Defined in - @ line 1
function lc --wraps='ls -ca' --wraps='ls -Ca' --description 'alias lc=ls -Ca'
  ls -Ca $argv;
end
