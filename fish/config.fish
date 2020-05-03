# Options
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"

# Colors
set green (set_color green)
set magenta (set_color magenta)
set normal (set_color normal)
set red (set_color red)
set yellow (set_color yellow)

set __fish_git_prompt_color_branch magenta --bold
set __fish_git_prompt_color_dirtystate white
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_merging yellow
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red


# Icons
set __fish_git_prompt_char_cleanstate ' 👍  '
set __fish_git_prompt_char_conflictedstate ' ⚠️  '
set __fish_git_prompt_char_dirtystate ' 💩  '
set __fish_git_prompt_char_invalidstate ' 🤮  '
set __fish_git_prompt_char_stagedstate ' 🚥  '
set __fish_git_prompt_char_stashstate ' 📦  '
set __fish_git_prompt_char_stateseparator ' | '
set __fish_git_prompt_char_untrackedfiles ' 🔍  '
set __fish_git_prompt_char_upstream_ahead ' ☝️  '
set __fish_git_prompt_char_upstream_behind ' 👇  '
set __fish_git_prompt_char_upstream_diverged ' 🚧  '
set __fish_git_prompt_char_upstream_equal ' 💯 ' 


function fish_prompt
	echo
  set last_status $status

  set_color $fish_color_cwd
  #printf '%s' (prompt_pwd)
  printf '%s' (pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)
  echo
  echo -n "🦩  "
  set_color normal
end

function fish_greeting
	echo
    fortune | cowsay
  echo
end

function tmux2
    set TERM screen-256color-bce
    tmux
end

# respect node PATH
set -gx PATH $PATH /Users/filipe/npm-global/bin
set PATH /usr/local/Cellar/node/12.8.1/lib/node_modules/@vue/cli/bin/vue.js $PATH 

# grep colors
# setenv -x GREP_OPTIONS "--color=auto"


