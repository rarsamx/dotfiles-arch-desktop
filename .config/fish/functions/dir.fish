# Defined in - @ line 1
function dir --wraps='dir --color=auto' --wraps='dir --color=auto --group-directories-first' --description 'alias dir=dir --color=auto --group-directories-first'
 command dir --color=auto --group-directories-first $argv;
end
