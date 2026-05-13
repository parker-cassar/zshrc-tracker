# Git aliases
alias gs='git status'
alias ga-='git add'
alias gaa='git add .'
alias gc='git commit -am'
alias gac='git add *; git commit -am'
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
alias gp='git push -u origin main'
alias gpl='git pull'

alias py='python3'

# Dotfile aliases
alias zrc='nvim ~/.zshrc'
alias nz='nvim ~/.zshrc'
alias vz='code ~/.zshrc'
alias cz='cursor ~/.zshrc'

alias szrc='source ~/.zshrc'
alias sz='source ~/.zshrc'
alias z_path='echo $ZSH'

# gicp [init_commit_msg] [repo_name] [pub for public]
gicp() {
  git init
  git add .
  git commit -m "$1"
  if [ "$3" = "pu" ] || [ "$3" = "pub" ] || [ "$3" = "public" ]; then
    gh repo create "$2" --public --source=. --push
  else
    gh repo create "$2" --private --source=. --push
  fi
}

gcp() {
  git commit -am "$1"
  git push
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
  (cd ~/zrc_git && git add zshrc && git commit -m "$1" && git push && cd -)
}

# Helper aliases
alias help_ruff='echo "
ruff format --diff .     # preview changes (no edits)
ruff format .            # apply formatting in place
ruff check .             # lint only (no fix)
ruff check --fix .       # lint + fix
ruff check --select I --fix .   # imports only (PEP8 order)
ruff check --fix . && ruff format .  # full pass
"'

export EDITOR='nvim'
export VISUAL='nvim'

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell" # ZSH_THEME="random" | echo $RANDOM_THEME | See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
alias zt='echo $RANDOM_THEME'
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(z fzf brew) # plugins=(z fzf brew) for oh-my-zsh, plugins=(z fzf brew) for zinit
source $ZSH/oh-my-zsh.sh
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
