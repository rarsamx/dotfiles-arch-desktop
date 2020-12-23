# Defined in - @ line 1
function tmuxc --wraps='TERM=screen-256color-bce tmux' --description 'alias tmux=TERM=screen-256color-bce tmux'
  env TERM=screen-256color-bce tmux $argv;
end
