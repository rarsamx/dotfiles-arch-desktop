function trashempty -w 'gio trash --empty' -d 'Completely deletes al files in Trash'

    read -n 1 -p 'echo "Files will be unrecoverable. Confirm deletion (y/n)? "' -l conf
    
    set conf (string lower $conf)
    if test (string lower $conf) = "y"
        echo 'gio trash --empty'
        gio trash --empty
    end
end

