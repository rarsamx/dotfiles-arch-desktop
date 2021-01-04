# Defined in - @ line 1
function cmus-current --wraps=cmus-remote\ -C\ status\ \|\ grep\ \ \"artist\\\|album\\\|title\" --description alias\ cmus-current=cmus-remote\ -C\ status\ \|\ grep\ \ \"artist\\\|album\\\|title\"
  cmus-remote -C status | grep  "artist\|album\|title" $argv;
end
