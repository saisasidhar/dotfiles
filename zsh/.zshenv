export PATH=$PATH:$HOME/apps

source "$HOME/.cargo/env"

export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOINSTALLPATH=/usr/local/go/bin
export PATH=$PATH:$GOINSTALLPATH
export PATH="$PATH:$(go env GOPATH)/bin"

export PATH=$PATH:$HOME/.poetry/bin
export PATH=$PATH:$HOME/.local/bin
