#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ======================== Supporting functions difs ======================== #
## Append "$1" to $PATH when not already in.
## This function API is accessible to scripts in /etc/profile.d
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

## bash parameter completion for the dotnet CLI
function _dotnet_bash_complete()
{
  local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n' # On Windows you may need to use use IFS=$'\r\n'
  local candidates

  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}
complete -f -F _dotnet_bash_complete dotnet

alias dailynotes_edit='nvim +"Obsidian today"'
alias dailynotes_showall='nvim +"Obsidian dailies"'

# ========================   Supporting variables   ========================= #
EXEPREFIX='/usr/bin/env'

# ========================          EXPORTS          ======================== #
export PS1="[\u@\h \W]\$ "
export COLORTERM='truecolor'
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less --incsearch"
export MANPAGER="less --incsearch"
export BROWSER="firefox"
export LANG='ru_RU.UTF-8' 
export LANGUAGE='ru_RU.UTF-8:be_BY.UTF-8:en_US.UTF-8' # used to set messages languages (as LC_MESSAGES) to a multi-valued value. `man locale(7)`. [GNU gettext with description of var](https://www.gnu.org/software/gettext/manual/html_node/The-LANGUAGE-variable.html)

## ------------------------     History settings     ------------------------ #
export HISTCONTROL='ignoredups' # no duplicates
export HISTSIZE=8192

## ------------------------    XDG Paths settings    ------------------------ #
export XDG_DATA_HOME="$HOME/.local/share/"
export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_STATE_HOME="$HOME/.local/state/"
export XDG_DATA_DIRS='/usr/share/:/usr/local/share/'
export XDG_CONFIG_DIRS='/etc/xdg/'
export XDG_CACHE_HOME="$HOME/.cache/"

## ------------------------    Password Store env    ------------------------ #
export PASSWORD_STORE_GENERATED_LENGTH=64
export PASSWORD_STORE_CLIP_TIME=10
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/passwords/"

## ------------------------    DOTNET environment    ------------------------ #
export DOTNET_INSTALL_DIR="$HOME/.dotnet/"
export DOTNET_ROOT="$HOME/.dotnet/"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

## ------------------------     SHITTY JAVA env      ------------------------ #
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export JAVA_FONTS=/usr/share/fonts/TTF

# ========================          ALIASES          ======================== #
alias ls='ls --color=auto'
alias lsa='ls -lah'
alias grep='grep --color=auto'
alias tree='tree -C'
alias xxd="xxd -c 16 -g 1"
alias octave="octave --gui"

## on/off disables/enables history saving onto disk. can be used for secure gpg usage.
alias secure_mode_on='set +o history'
alias secure_mode_off='set -o history'

## download audio from some video link
alias yt-dlp-download-audio='yt-dlp --audio-quality 0 --audio-format best -x'

## connect to or create tmux session
alias tmux='tmux attach || tmux new'

# ========================       PATH settings       ======================== #
## User-executable PATH
append_path "$HOME/.local/bin/"

## .NET PATH
append_path "$HOME/.dotnet/"
append_path "$HOME/.dotnet/tools/"

## Flutter PATH
append_path "$XDG_DATA_HOME/flutter/sdk/development/flutter/bin/"

export PATH

unset -f append_path

# ========================       Key bindings        ======================== #
# bind `up` and `down` arrow to search through history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ========================       Other options       ======================== #
## prepends `cd` if input just a path
shopt -s autocd

## disallow existing regular files to be overwritten \
## by redirection of shell output
## if set, use `>|` to force overwritting
set -o noclobber

## checks the window size after each command
shopt -s checkwinsize

## now shell doesn't closes after receive EOF (but only 199715979263 attempts)
export IGNOREEOF=199715979263
