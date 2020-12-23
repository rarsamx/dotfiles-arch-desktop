#
# ~/.bashrc
#

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lah --group-directories-first'
alias cpi='cp -i'
alias pacinst='
echo "sudo pacman -S --needed"
sudo pacman -S --needed '
alias pacupd='
echo "sudo pacman -Syu"
sudo pacman -Syu'
alias pacuninst='
echo "sudo pacman -Rcns"
sudo pacman -Rcns'
alias makeaur='
echo "makepkg -scir --needed"
makepkg -scir --needed'
alias c='bc -l <<<'
alias snaplist='
echo "sudo snapper -c root list"
sudo snapper -c root list'
alias snapdel='
echo "sudo snapper -c root delete"
sudo snapper -c root delete'
alias snapshot='
echo "sudo snapper -C root create --description"
sudo snapper -C root create --description'
alias snappre='
echo "sudo snapper -c root create -t pre -p --description"
sudo snapper -c root create -t pre -p'
alias snappost='
echo "snapper -c root create -t post --pre-number"
snapper -c config create -t post --pre-number'
alias gitdotfiles='/usr/bin/git --git-dir=/home/papa/.gitdotfiles/ --work-tree=/home/papa'
alias -s lc='ls -Ca'
