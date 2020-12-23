function trash -w 'gio trash' -d 'Moves a file/directory to the trash'
    set -l filename $argv
    if test -e $filename
        echo 'gio trash' $filename
        gio trash $filename
    else
        echo $filename "file not found"
    end
end

