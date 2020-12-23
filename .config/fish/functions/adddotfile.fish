function  adddotfile -d 'Adds a configuration file to git'
    gitdotfiles add $argv 
    gitdotfiles commit -m "Added $argv"
end
