# This file contains kubernetes related shortcuts
alias k="kubectl"
alias ke="open ~/.kube/configs"

# This merges multiple kubeconfigs into your active configuration.
# Place fresh config files in ~/.kube/configs
mkdir -p ~/.kube/configs
chmod 0700 ~/.kube/configs
export KUBECONFIG=~/.kube/config:$(find ~/.kube/configs -type f | tr '\n' ':')

# This makes it easy to switch contexts without typing them out.
# It requires kubectx and dialog.
function kx {
    if ! command -v dialog &> /dev/null; then
        echo "Install 'dialog' with \`brew install dialog\`"
    elif ! command -v kubectx &> /dev/null; then
        echo "Install 'kubectx' with \`brew install kubectx\`"
    else
        choice=`dialog --stdout --keep-tite --menu "Choose Context" 0 0 0 $(kubectx | nl)`
        if [ $? -eq 0 ]; then # OK was pressed
            ctx=$(kubectx | sed -n "${choice}p")
            kubectx "$ctx"
        else
            echo "Context switch aborted."
        fi
    fi
}
