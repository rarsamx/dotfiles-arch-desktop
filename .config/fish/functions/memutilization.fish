# Defined in - @ line 1
function memutilization 
    for pid in (pgrep $argv)
        ps -q $pid -o rss= | sed 's/total *\([0-9]*\)\([A-Z]\)/'$argv': \1 \2/; :a; s/\B[0-9]\{3\}\>/,& kB/; ta'
    end
end
