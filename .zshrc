export PATH="$HOME/.tmuxifier/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim

ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#disable START/STOP output control (<C-S>, <C-Q>)
stty -ixon

# 重啟 puma
#
# - rpu       → 啟動或重啟（如果已有 pid）
# - rpu kill  → 殺掉 process，不重啟
rpu() {
  emulate -L zsh
  if [[ -d tmp ]]; then
    local action=$1
    local pid
    local animal

    if [[ -f config/puma.rb ]]; then
      animal='puma'
    else
      echo "No puma directory, aborted."
      return 1
    fi

    if [[ -r tmp/pids/server.pid && -n $(ps h -p `cat tmp/pids/server.pid` | tr -d ' ') ]]; then
      pid=`cat tmp/pids/server.pid`
    fi

    if [[ -n $action ]]; then
      case "$action" in
        pry)
          if [[ -n $pid ]]; then
            kill -9 $pid && echo "Process killed ($pid)."
          fi
          rserver_restart $animal
          ;;
        kill)
          if [[ -n $pid ]]; then
            kill -9 $pid && echo "Process killed ($pid)."
          else
            echo "No process found."
          fi
          ;;
        *)
          if [[ -n $pid ]]; then
            # TODO: control unicorn
            pumactl -p $pid $action
          else
            echo 'ERROR: "No running PID (tmp/pids/server.pid).'
          fi
      esac
    else
      if [[ -n $pid ]]; then
        # Alternatives:
        # pumactl -p $pid restart
        # kill -USR2 $pid && echo "Process killed ($pid)."

        # kill -9 (SIGKILL) for force kill
        kill -9 $pid && echo "Process killed ($pid)."
        rserver_restart $animal $([[ "$animal" == 'puma' ]])
      else
        rserver_restart $animal $([[ "$animal" == 'puma' ]])
      fi
    fi
  else
    echo 'ERROR: "tmp" directory not found.'
  fi
}

# 這是 rpu 會用到的 helper function
rserver_restart() {
  case "$1" in
    puma)
      shift
      bundle exec puma -C config/puma.rb config.ru --pidfile "tmp/pids/server.pid"
      ;;
    *)
      echo 'invalid argument'
  esac
}

# Open github pull request url from sha
export GITHUB_UPSTREAM=rails

pr_sha() {
  git log --merges --ancestry-path --oneline $1..$git_current_branch | grep 'pull request' | tail -n1 | awk '{print $5}' | cut -c2- | xargs -I % open https://github.com/$GITHUB_UPSTREAM/${PWD##*/}/pull/%
}

# Check if we can read given files and source those we can.
xsource() {
  if (( ${#argv} < 1 )) ; then
      printf 'usage: xsource FILE(s)...\n' >&2
      return 1
  fi

  while (( ${#argv} > 0 )) ; do
      [[ -r "$1" ]] && source "$1"
      shift
  done
  return 0
}

zrclocal() {
  xsource "/etc/zsh/zshrc.local"
  xsource "${HOME}/.zshrc.local"
  return 0
}

zrclocal
