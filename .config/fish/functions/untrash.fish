function untrash -d 'Restores a file from the Trash'

    set -l trashpath ~/.local/share/Trash
    set -l filename $argv
    set -l trashinfofn $trashpath/info/$filename.trashinfo
    set -l trashfn $trashpath/files/$filename

    # If exists in the trash we can try to restore
    if test -e $trashfn -a -e $trashinfofn
        set -l originalfn (string sub -s6 (grep '^Path=' {$trashinfofn}))
        set -l originalfilepath (string split --right --max 1 '/' $originalfn)[1]

        echo Restoring $originalfn 
        mv -i $trashfn $originalfilepath

        # We need to check if the file was movedbecause if the user does not 
        # accept the overwrite the status is still OK
        if test ! -e $trashfn
            rm $trashinfofn
        else
            echo File not restored
        end
    else
        echo $filename is not in Trash
    end
end

