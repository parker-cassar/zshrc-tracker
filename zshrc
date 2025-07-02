# Git aliases
alias gs='git status'
alias ga-='git add'
alias gaa='git add *'
alias gc='git commit -am'
alias gl='git log --oneline --graph --decorate'
alias glt='git log --graph --pretty=format:"%C(auto)%h %cd (%C(bold blue)$(git branch --show-current)%Creset) %s" --date=format:"%Y-%m-%d %H:%M:%S"'
alias glp='git --no-pager log --graph --pretty=format:"%C(auto)%h %cd (%C(bold blue)$(git branch --show-current)%Creset) %s" --date=format:"%Y-%m-%d %H:%M:%S"'
alias glpp='git --no-pager log --graph --pretty=format:"%C(auto)%h %cd (%C(bold blue)$(git branch --show-current)%Creset) %s" --date=format:"%Y-%m-%d %H:%M:%S" -10'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gm='git merge'
alias gr='git remote add origin'
alias gcH='git checkout HEAD'
alias grH='git reset HEAD'
alias removeUntracked='git clean -fd'
alias gfix='git commit --amend'
alias gpl='git pull'

alias py='python3'

# Dotfile aliases
alias zrc='cursor ~/.zshrc'
alias cz='cursor ~/.zshrc'
alias vzrc='vim ~/.zshrc'
alias vz='vim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias sz='source ~/.zshrc'

gp() {
  if [ -z "$1" ]; then
    git push
  elif [ "$2" == "priv" ] || [ "$2" == "private" ] || [ "$2" == "pr" ]; then
    gh repo create "$1" --private --source=. --push
  else
    gh repo create "$1" --public --source=. --push
  fi
}

# Custom commit with backdate
# Example: gbc 24-06-10 15 "msg"
gbc() {
  local raw_date="$1"
  local hour="$2"
  shift 2
  IFS=- read yy mm dd <<< "$raw_date"
  yy="20$yy"
  mm=$(printf "%02d" "$mm")
  dd=$(printf "%02d" "$dd")
  hr=$(printf "%02d" "$hour")
  
  local rand_min=$((RANDOM % 60))
  local rand_sec=$((RANDOM % 60))
  min=$(printf "%02d" "$rand_min")
  sec=$(printf "%02d" "$rand_sec")

  local date="${yy}-${mm}-${dd}T${hr}:${min}:${sec}"
  local msg="$*"
  GIT_COMMITTER_DATE="$date" git commit --date="$date" -am "$msg"
}

gbc_ym() {
  local yy="$1"
  local mm="$2"
  local name="${3:-my_gbc}"  # optional: name for the generated function
  yy=$(printf "%02d" "$yy")
  mm=$(printf "%02d" "$mm")
  eval "$name() {
    local day_hour=\"\$1\"
    shift
    IFS=- read dd hr <<< \"\$day_hour\"
    gbc \"$yy-$mm-\$dd\" \"\$hr\" \"\$@\"
  }"
}

gpz() {
  (cd ~/zrc_git && git add zshrc && git commit -m "$1" && git push)
}

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell" # ZSH_THEME="random" | echo $RANDOM_THEME | See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
alias zt='echo $RANDOM_THEME'
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(z fzf brew) # Which plugins would you like to load? Standard plugins can be found in $ZSH/plugins/, Custom plugins may be added to $ZSH_CUSTOM/plugins/, Example format: plugins=(rails git textmate ruby lighthouse), Add wisely, as too many plugins slow down shell startup.
source $ZSH/oh-my-zsh.sh