function snappost -w 'snapper -c root create -t post --pre-number' -d 'Create a post process btrfs snapshot'
    echo "snapper -c root create -t post --pre-number" \"$argv\"
    snapper -c config create -t post --pre-number \"$argv\"
end
