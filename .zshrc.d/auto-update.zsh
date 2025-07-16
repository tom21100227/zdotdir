() {
  # Define the timestamp file path
  local last_update_file="$HOME/.config/zsh/.last-update"
  # Get the current time in seconds since the epoch
  local now
  now=$(date +%s)
  local last_update_time

  # Check if the timestamp file exists
  if [[ -f "$last_update_file" ]]; then
    # Read the last update time from the file
    last_update_time=$(cat "$last_update_file")
    # Calculate the time difference in seconds
    local time_diff=$((now - last_update_time))

    # If less than 24 hours (86400 seconds) have passed, do nothing.
    if (( time_diff < 86400 )); then
      return
    fi
  fi

  # The path to the interactive script
  local update_script_path="$HOME/.config/zsh/.zshrc.d/run-updates-interactive.sh"

  # Use osascript to run the update script in a new iTerm window
  # and pass the current timestamp as an argument.
  osascript -e 'tell application "iTerm" to create window with default profile command "'"'$update_script_path' '$now'"'"' >/dev/null 2>&1 &

}
