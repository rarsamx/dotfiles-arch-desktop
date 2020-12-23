# Defined in - @ line 1
function cpi -w 'cp -i' -d 'alias cpi=cp -i'
    echo "cp -i" $argv
    cp -i $argv;
end
