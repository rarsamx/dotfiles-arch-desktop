function snapshot -w 'sudo snapper -c root create --description' -d 'Create a btrfs snapshot'
    echo "sudo snapper -c root create --description" \"$argv\"
    sudo snapper -c root create --description \"$argv\"
end
