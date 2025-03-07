[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/mongodb-community@5.0/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sohjunde/Desktop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sohjunde/Desktop/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sohjunde/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sohjunde/Desktop/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/Users/sohjunde/Desktop/google-cloud-sdk/bin:$PATH"

# to load pyenv automatically
# gotten this instruction from running `pyenv init`
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fix issue where GOBIN is not set, and globally installed packages are not accessible
# ref: https://www.reddit.com/r/golang/comments/vycgel/running_into_an_issue_on_mac_os_with_gobin/
export PATH=`go env GOPATH`/bin/:$PATH

# spresso: showing which kubectl env we're currently in
function kube_context() {
    # could have used $?, but it was easier with a string compare
    local ctx=$(kubectl config current-context 2>&1)
    case $ctx in
        'gke_boxed-api_us-east4_admin')
            echo -n '<boxed-admin>'
            ;;

        'gke_aeon-malaysia-staging_asia-southeast1_staging')
            echo -n '<aeonmy-staging>'
            ;;

        'gke_aeon-malaysia-prod_asia-southeast1_main')
            echo -n '<aeonmy-prod>'
            ;;

        'gke_aeon-vietnam-staging_asia-southeast1_staging')
            echo -n '<aeonvn-staging>'
            ;;
        
        'gke_aeon-vietnam-prod_asia-southeast1_prod')
            echo -n '<aeonvn-prod>'
            ;;
        
        'gke_spresso-saas-prod_us-east4_main')
            echo -n '<spresso-prod>'
            ;;

        'gke_spresso-saas-staging_us-east4_main')
            echo -n '<spresso-staging>'
            ;;

        'gke_msg-boxed-staging_us-east4_staging')
            echo -n '<msgboxed-staging>'
            ;;
        
        'gke_msg-boxed-prod_us-east4_pro')
            echo -n '<msgboxed-prod>'
            ;;

        *)
            echo -n '<>'
            ;;
    esac
}
