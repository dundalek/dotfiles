
set -g __fish_git_prompt_show_informative_status 1
# set -g __fish_git_prompt_hide_untrackedfiles 1
#
set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
# set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_ahead "↑·"
# set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""
#
# set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "+"
# set -g __fish_git_prompt_char_untrackedfiles "…"
# set -g __fish_git_prompt_char_conflictedstate "✖"
# set -g __fish_git_prompt_char_cleanstate "✔"
#
set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles blue
# set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green --bold

# Fish git prompt
# set __fish_git_prompt_showdirtystate 'yes'
# set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showuntrackedfiles 'yes'
# set __fish_git_prompt_showupstream 'verbose'
# set __fish_git_prompt_color_branch yellow
# set __fish_git_prompt_color_upstream_ahead green
# set __fish_git_prompt_color_upstream_behind red

# Status Chars
# set __fish_git_prompt_char_dirtystate '⚡'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_untrackedfiles '☡'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '+'
# set __fish_git_prompt_char_upstream_behind '-'

function fish_prompt
  command powerline-go -shell bare -mode compatible -modules "time,nix-shell,venv,ssh,cwd,perms,git,hg,jobs,exit,root" -git-disable-stats stashed
end

function fish_prompt_old --description 'Write out the prompt'
  #Save the return status of the previous command
  set stat $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
      set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set -q __fish_prompt_normal
      set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __fish_color_blue
      set -g __fish_color_blue (set_color -o blue)
  end

  if not set -q __fish_color_green
      set -g __fish_color_green (set_color -o green)
  end

  if not set -q __fish_color_grey
      set -g __fish_color_grey (set_color -o black)
  end

  #Set the color for the status depending on the value
  set __fish_color_status (set_color -o green)
  if test $stat -gt 0
      set __fish_color_status (set_color -o red)
  end

  switch $USER
    case root toor
      if not set -q __fish_prompt_cwd
          if set -q fish_color_cwd_root
              set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
          else
              set -g __fish_prompt_cwd (set_color $fish_color_cwd)
          end
      end

      printf '%s@%s %s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

    case '*'
      if not set -q __fish_prompt_cwd
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end

      #printf '[%s] %s%s@%s %s%s %s(%s)%s \f\r> ' (date "+%H:%M:%S") "$__fish_color_blue" $USER $__fish_prompt_hostname "$__fish_prompt_cwd" "$PWD" "$__fish_color_status" "$stat" "$__fish_prompt_normal"

      # %s%s@%s
      # "$__fish_color_green" $USER $__fish_prompt_hostname
      printf '%s%s %s%s%s%s $ ' "$__fish_color_grey" (date "+%H:%M") "$__fish_color_blue" "$PWD" "$__fish_prompt_normal" (__fish_git_prompt)

      # alternative

  end
end
