#!/bin/bash

# Creates installation log, with timestamped commands and their output
# and store in a file MyLog.txt

# Start a new script session, logging to a temporary file
temp_file=$(mktemp)

# Run the script command to capture all input and output
script -q -f "$temp_file" -c "
  bash --rcfile <(
    echo '. ~/.bashrc; 
    PROMPT_COMMAND+=\"echo \$(date +%Y-%m-%d\ %H:%M:%S) \# \$(history 1)\"'
  )
"

# Clean the log file by removing escape sequences, other unwanted characters,
# consecutive blank lines, and wrap lines at a maximum width of 72 characters
cat "$temp_file" | \
  sed 's/\x1B\[[0-9;]*[JKmsu]//g' | \
  sed 's/\x1B\[?2004[hl]//g' | \
  tr -d '\r' | \
  col -b | \
  sed '/^$/N;/^\n$/D' > MyLog.txt

# Remove the temporary file
rm "$temp_file"

echo "Clean log saved to MyLog.txt"
