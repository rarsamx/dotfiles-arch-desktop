function snaplist -w 'sudo snapper -c root list' -d 'List Btrfs snapshots'
    echo "sudo snapper -c root list" $argv
    sudo snapper -c root list $argv
end
