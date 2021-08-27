source ~/.zsh-snap/zsh-snap/znap.zsh

znap source marlonrichert/zsh-autocomplete

####

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/jessy/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Partial completion
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

# Move one word fwd or bwd
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

alias venvneural="source ~/lilt_neural/bin/activate"
alias pip="pip3"
venvneural
export PATH="/usr/local/opt/mysql@5.7/bin:/usr/local/sbin/:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jessy/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jessy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jessy/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jessy/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(nodenv init -)"

# Running neural
export NEURAL_HOME=$REPO_DIR/neural
export PYTHONPATH=${NEURAL_HOME}/src/python/:.:..:$PYTHONPATH

export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/legacy_credentials/jessy@lilt.com/adc.json
export GOOGLE_CLOUD_PROJECT="lilt_development"

## CORE SETUP

export REPO_DIR=$HOME

# Phrasal
export PHRASAL_HOME=$REPO_DIR/phrasal

# lex
export LEX_HOME=$REPO_DIR/lex

# lilt/core
export CORE_HOME=$REPO_DIR/core
export CLASSPATH=$REPO_DIR/core/build/install/core/lib/*

export NLP_SCRIPTS=$REPO_DIR/nlp_scripts

# PATH setup for lilt software
export PATH=$PATH:$PHRASAL_HOME/scripts
export PATH=$PATH:$PHRASAL_HOME/src-cc/kenlm/bin
export PATH=$PATH:$CORE_HOME/scripts:$CORE_HOME/prod
export PATH=$PATH:$FASTALIGN_BINDIR
export PATH=$PATH:$NLP_SCRIPTS

# some handy aliases
source $CORE_HOME/prod/alias.bash

alias unmount-slurm="umount mnt/slurm"
alias mount-slurm="sshfs -o IdentityFile=~/.ssh/google_compute_engine.pub jessy_lilt_com@slurm-login1.us-central1-c.lilt-research:/home mnt/slurm"

# cs285 mujoco
export LD_LIBRARY_PATH=~/.mujoco/mujoco200/bin

# sublime
alias sublime="open -a /Applications/Sublime\ Text.app"

# web pages to actions, chromedriver
export PATH=$PATH:/Users/jessy/personal/chromedriver

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jessy/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jessy/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jessy/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jessy/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export RBENV_ROOT=/usr/local/var/rbenv

# For calling Sublime from the terminal
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/.bin/subl
export PATH=$PATH:~/.bin/
