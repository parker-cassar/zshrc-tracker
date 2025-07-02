# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(z fzf brew)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"




# Git aliases
alias gs='git status'
alias ga-='git add'
alias gaa='git add *'
alias gc='git commit -am'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias glt='git log --graph --pretty=format:"%C(auto)%h %cd (%C(bold blue)$(git branch --show-current)%Creset) %s" --date=format:"%Y-%m-%d %H:%M:%S"'
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
alias vzrc='vim ~/.zshrc'
alias szrc='source ~/.zshrc'

gp() {
  if [ -z "$1" ]; then
    git push
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
