#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '

# enable color support of ls and also add handy aliases
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -ahlF'
alias la='ls -ah'
alias l='ls -CFh'
alias lc='ls -Ca'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias c='bc -l <<<'
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
