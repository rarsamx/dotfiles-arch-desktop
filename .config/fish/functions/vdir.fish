# Defined in - @ line 1
function vdir --wraps='vdir --color=auto' --wraps='vdir --color=auto --group-directories-first' --description 'alias vdir=vdir --color=auto --group-directories-first'
 command vdir --color=auto --group-directories-first $argv;
end
