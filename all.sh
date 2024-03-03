# This file is sourced in .zshrc

dir=$(dirname $0)

# This is paranoid; shells don't usually
# let a file source itself.
for file in $dir/*.sh; do
    if [[ "$file" != "$0" ]]; then
        source "$file"
    fi
done
