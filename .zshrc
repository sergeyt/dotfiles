setopt EXTENDED_GLOB

# measuring shell init
# zmodload zsh/datetime
# __start=$EPOCHREALTIME

# JetBrains "Shell Environment Loading" mode
if [[ -n "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  unsetopt noclobber 2>/dev/null
  return
fi

# safe for non-interactive shells
[[ -o interactive ]] || return

# --- fast completions ---
autoload -Uz compinit

# Use a stable cache file (faster) and avoid per-start checks
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

# -C skips recompilation check; -d sets dump file
compinit -C -d "$ZSH_COMPDUMP"

# --- fzf integration ---
eval "$(fzf --zsh)"

# --- forgit (fzf git UI) ---
export FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS='--sort=-committerdate'
if [[ -f /opt/homebrew/opt/forgit/share/forgit/forgit.plugin.zsh ]]; then
  source /opt/homebrew/opt/forgit/share/forgit/forgit.plugin.zsh
elif [[ -f /usr/local/opt/forgit/share/forgit/forgit.plugin.zsh ]]; then
  source /usr/local/opt/forgit/share/forgit/forgit.plugin.zsh
fi

# --- fnm (Node) ---
eval "$(fnm env --use-on-cd)"

# --- Antidote (plugins) ---
# Homebrew path differs between Apple Silicon and Intel; try both
if [[ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
elif [[ -f /usr/local/opt/antidote/share/antidote/antidote.zsh ]]; then
  source /usr/local/opt/antidote/share/antidote/antidote.zsh
fi

# Load plugins from file (create it in step 3)
antidote load

# --- Starship prompt ---
eval "$(starship init zsh)"

# JetBrains vmoptions
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"
if [[ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]]; then
  . "${___MY_VMOPTIONS_SHELL_FILE}"
fi

# bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# ngrok completion
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

alias mongo_proxy="ssh -i '~/.ssh/jump-host.pem' -D 1080 -C -N ec2-user@ec2-44-208-137-51.compute-1.amazonaws.com"

# --- Print time + duration after each command ---
autoload -Uz add-zsh-hook
zmodload zsh/datetime

: ${CMD_TIME_THRESHOLD:=0}  # seconds; set e.g. 1 or 2 if you want only slow commands

__cmd_start=0

__timer_preexec() {
  __cmd_start=$EPOCHREALTIME
}

__timer_precmd() {
  [[ -o interactive ]] || return
  (( __cmd_start == 0 )) && return

  local end=$EPOCHREALTIME
  local dur_s
  dur_s=$(awk "BEGIN {print $end - $__cmd_start}")

  # threshold
  awk "BEGIN {exit !($dur_s >= $CMD_TIME_THRESHOLD)}" || { __cmd_start=0; return; }

  local dur
  dur=$(printf "%.3fs" "$dur_s")
  print -P "%F{244}↳ completed %D{%H:%M:%S} · took ${dur}%f"

  __cmd_start=0
}

add-zsh-hook preexec __timer_preexec
add-zsh-hook precmd  __timer_precmd

# print "Shell startup took $(printf "%.3f" "$(echo "$EPOCHREALTIME - $__start" | bc)") seconds"

# Windsurf
[[ -d "$HOME/.codeium/windsurf/bin" ]] && export PATH="$HOME/.codeium/windsurf/bin:$PATH"
