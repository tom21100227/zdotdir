#!/bin/zsh

# Update the timestamp file with the time passed from the parent script
if [[ -n "$1" ]]; then
  echo "$1" > "$HOME/.config/zsh/.last-update"
  echo "Timestamp updated."
fi

# This script runs the update tasks in an interactive terminal window.

echo "Starting daily auto-update..."
echo "---------------------------------"

# Navigate to the zsh config directory for git operations
echo "Syncing zsh configuration..."
cd -- "$HOME/.config/zsh"
if ! git diff-index --quiet HEAD --; then
    echo "You have unstaged changes in zsh configuration."
    echo "Please stage your changes before continuing."
    echo "Run 'git add .' to stage all changes, or stage specific files."
    echo "Press [s] to skip this step, or any other keys if you resolved the issue and committed your changes."
    read -k1 -s
fi
if [[ $REPLY == [Ss] ]]; then
    echo "Skipping zsh configuration update."
else
    echo "resolved zsh configuration update."
    git pull --rebase && git push
fi
# Navigate to the dotfiles directory for git operations
echo "Syncing dotfiles..."
cd -- "$HOME/.dotfiles"
if ! git diff-index --quiet HEAD --; then
    echo "You have unstaged changes in dotfiles."
    echo "Please stage your changes before continuing."
    echo "Run 'git add .' to stage all changes, or stage specific files."
    echo "Press [s] to skip this step, or any other keys if you resolved the issue and committed your changes."
    read -k1 -s
fi
if [[ $REPLY == [Ss] ]]; then
    echo "Skipping dotfiles update."
else
    echo "resolved dotfiles update."
    git pull --rebase && git push
fi
echo "---------------------------------"

echo "Update `tldr`"
tldr --update --quiet
echo "Updated `tldr`"
echo "---------------------------------"

# Run brew upgrade
echo "Running brew upgrade..."
brew upgrade --quiet
echo "---------------------------------"


echo "---------------------------------"
echo "Auto-update complete."
echo "Press any key to close this window."
read -k1 -s # Wait for a single key press
exit
