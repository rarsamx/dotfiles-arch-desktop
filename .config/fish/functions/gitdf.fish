# Defined in - @ line 1
function gitdf --wraps='/usr/bin/git --git-dir=/home/papa/.gitdotfiles/ --work-tree=/home/papa' --description 'alias gitdotfiles=/usr/bin/git --git-dir=/home/papa/.gitdotfiles/ --work-tree=/home/papa'
  /usr/bin/git --git-dir=/home/papa/.gitdotfiles/ --work-tree=/home/papa $argv;
end
