function snappre -w 'sudo snapper -c root create -t pre -p --description' -d 'Create a pre-process snapshot'
    echo "sudo snapper -c root create -t pre -p --description" $argv
    sudo snapper -c root create -t pre -p $argv
end
