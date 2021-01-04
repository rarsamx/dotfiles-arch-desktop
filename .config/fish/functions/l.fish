# Defined in - @ line 1
function l --wraps='ls -CFh' --description 'alias l=ls -CFh'
  ls -C $argv;
end
