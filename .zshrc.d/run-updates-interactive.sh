#!/bin/zsh

# This script runs the update tasks in an interactive terminal window.

echo "Starting daily auto-update..."
echo "---------------------------------"

# Navigate to the zsh config directory for git operations
echo "Syncing zsh configuration..."
cd -- "$HOME/.config/zsh" && git pull --rebase && git push
echo "---------------------------------"

# Navigate to the dotfiles directory for git operations
echo "Syncing dotfiles..."
cd -- "$HOME/.dotfiles" && git pull --rebase && git push
echo "---------------------------------"

# Run brew upgrade
echo "Running brew upgrade..."
brew upgrade
echo "---------------------------------"

# Update the timestamp file with the time passed from the parent script
if [[ -n "$1" ]]; then
  echo "$1" > "$HOME/.config/zsh/.last-update"
  echo "Timestamp updated."
fi

echo "---------------------------------"
echo "Auto-update complete."
echo "Press any key to close this window."
read -k1 -s # Wait for a single key press
exit
