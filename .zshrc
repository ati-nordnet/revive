# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Setting for UTF-8 terminal support 
export LC_ALL="en_US.UTF-8"
export LANG=$LC_ALL
export LANGUAGE=$LC_ALL

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/opt/homebrew/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/corretto-19.0.2/Contents/Home"
export M2_HOME="/opt/homebrew/Cellar/maven/3.9.1"
export PATH="$M2_HOME/bin:$JAVA_HOME/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias bbc='bitbucket_server_cli clone -s https://scm.prod.nordnet.se'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
alias k=kubectl
alias tf=terraform

# Needed for M1 Macs
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# For Classic SV
alias svdb-connect='gcloud container clusters get-credentials production --zone europe-west3-a --project alpa-chino && 
export READ_ONLY_POD_NAME=$(kubectl get pods --namespace production -l "app=pgbouncer-read-only" -o jsonpath="{.items[0].metadata.name}") &&
kubectl port-forward $READ_ONLY_POD_NAME --namespace production 6432:6432'

# For Classic SV (Test)
alias svdb-test-connect='gcloud container clusters get-credentials sv-test-cluster --zone europe-north1-a --project shareville-test && 
export READ_ONLY_POD_NAME=$(kubectl get pods --namespace sv-test -l "app=pgbouncer" -o jsonpath="{.items[0].metadata.name}") &&
kubectl port-forward $READ_ONLY_POD_NAME --namespace sv-test 6432:6432'

alias rabbitmq-connect='gcloud container clusters get-credentials production --zone europe-west3-a --project alpa-chino &&
export RABBITMQ_POD_NAME=$(kubectl get pods --namespace production -l "app=rabbitmq-ha" -o jsonpath="{.items[0].metadata.name}") &&
kubectl port-forward $RABBITMQ_POD_NAME --namespace production 5672:5672 15672:15672'

# For NNX
alias dev-comments-connect='gcloud container clusters get-credentials main --region europe-north1 --project team-svd-cluster-10097 && 
kubectl port-forward svc/cloudsql-proxy-shareville-comments --namespace shareville 5432:5432'

alias prod-comments-connect='gcloud container clusters get-credentials main --region europe-north1 --project prod-cluster-25354 && 
kubectl port-forward svc/cloudsql-proxy-shareville-comments --namespace shareville 5432:5432'

alias dev-profiles-connect='gcloud container clusters get-credentials main --region europe-north1 --project team-svd-cluster-10097 && 
kubectl port-forward svc/cloudsql-proxy-shareville-profiles --namespace shareville 5432:5432'

alias prod-profiles-connect='gcloud container clusters get-credentials main --region europe-north1 --project prod-cluster-25354 && 
kubectl port-forward svc/cloudsql-proxy-shareville-profiles --namespace shareville 5432:5432'

alias dev-instruments-connect='gcloud container clusters get-credentials main --region europe-north1 --project team-svd-cluster-10097 && 
kubectl port-forward svc/cloudsql-proxy-shareville-instruments --namespace shareville 5432:5432'

alias prod-instruments-connect='gcloud container clusters get-credentials main --region europe-north1 --project prod-cluster-25354 && 
kubectl port-forward svc/cloudsql-proxy-shareville-instruments --namespace shareville 5432:5432'

alias dev-portfolios-connect='gcloud container clusters get-credentials main --region europe-north1 --project team-svd-cluster-10097 && 
kubectl port-forward svc/cloudsql-proxy-shareville-portfolios --namespace shareville 5432:5432'
alias test-portfolios-connect='gcloud container clusters get-credentials main --region europe-north1 --project test-cluster-29260 && 
kubectl port-forward svc/cloudsql-proxy-shareville-portfolios --namespace shareville 5432:5432'

alias prod-portfolios-connect='gcloud container clusters get-credentials main --region europe-north1 --project prod-cluster-25354 && 
kubectl port-forward svc/cloudsql-proxy-shareville-portfolios --namespace shareville 5432:5432'

alias dev-sv-notifications-history-connect='gcloud container clusters get-credentials main --region europe-north1 --project team-svd-cluster-10097 && 
kubectl port-forward svc/cloudsql-proxy-sv-notifications-history --namespace shareville 5432:5432'
alias test-sv-notifications-history-connect='gcloud container clusters get-credentials main --region europe-north1 --project test-cluster-29260 && 
kubectl port-forward svc/cloudsql-proxy-sv-notifications-history --namespace shareville 5432:5432'
alias prod-sv-history-notifications-connect='gcloud container clusters get-credentials main --region europe-north1 --project prod-cluster-25354 && 
kubectl port-forward svc/cloudsql-proxy-sv-notifications-history --namespace shareville 5432:5432'

# Erlang
export PATH="/usr/local/opt/erlang@21/bin:$PATH"

# terraform
export PATH="/usr/local/opt/terraform@0.11/bin:$PATH"

# dnsflush
alias dnsflush='sudo killall -HUP mDNSResponder;sleep 2;'

# lists versions of brew packages and lists all version if no input is given
function brewv() {
  packs=$(brew list --version -1)
  casks=$(brew cask list --version -1)

  echo "::PACKAGES::"
  echo "$packs\n"
  echo "::CASKS::"
  echo "$casks"
}

# removes branches locally which is merged or removed
function prunegit() {
  git fetch --all --prune && git checkout master && git branch --merged | grep -v master | xargs git branch -d
}

export PATH="/usr/local/sbin:$PATH"

# list installed java versions
function jlist() {
  echo "-= DETECTED VERSIONS =-"
  /usr/libexec/java_home -V
}

# change java version
function jversion() {
  echo "-= DETECTED VERSIONS =-"
  /usr/libexec/java_home -V
  echo "\n"
  if [ $# -ne 0 ]; then
    # need to unset first to work with Big Sur
    unset JAVA_HOME
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export PATH=$JAVA_HOME/bin:$PATH
  fi
  echo "-= YOUR JAVA VERSION IS NOW =-"
  java -version

  echo "To select version: jversion <detected version> e.g. 'jversion 1.8' or 'jversion 11'"
}

# get pid
function pidport() {
    get_pid=$(lsof -t -i :$1)
    echo "Your process id (pid) on port $1 is: $get_pid"
}

# kill process on port
function killport() {
    read "REPLY?Kill process on port $1? [y/N]: "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then 
      kill -9 $(lsof -t -i :$1)
      echo "-=! KILLED PROCCESS ON PORT [[$1]] !=-"
    fi
}

function linkfile() {
  local name=$1

  local from="$HOME/$name"
  local to="$PWD/$name"

  if [ ! -e $from -o $force_flag -ne 0 ]; then
    ln -fns $to $from

    echo "Link \"$from\""
  else
    echo "Skip \"$from\": File exists"
  fi
}

alias git-pull-all="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull"

function clone-nordnet-private {
  gh repo list nordnet-private --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo" -- -q 2>/dev/null || (
    cd "$repo"
    # Handle case where local checkout is on a non-main/master branch
    # - ignore checkout errors because some repos may have zero commits, 
    # so no main or master
    # https://stackoverflow.com/a/68770988
    git checkout -q master 2>/dev/null || true
    git pull -qr
  )
done
}

function clone-shareville() {
  gh repo list shareville --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo"
done
}

# include fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# include .aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
source ~/google-cloud-sdk/path.zsh.inc
# The next line enables shell command completion for gcloud.
source ~/google-cloud-sdk/completion.zsh.inc
# setup autocomplete in the current zsh shell
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

## enable zsh auto suggestions
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
## zsh-syntax-highlighting must be last
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')
source ~/powerlevel10k/powerlevel10k.zsh-theme

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/atiali/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/atiali/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/atiali/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/atiali/google-cloud-sdk/completion.zsh.inc'; fi
