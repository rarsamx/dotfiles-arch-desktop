function snapdel -w 'sudo snapper -c root delete' -d 'Delete btrfs snapshot'
    echo "sudo snapper -c root delete" $argv
    sudo snapper -c root delete $argv
end
