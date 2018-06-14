#!/bin/sh 
bold=$(tput bold)
normal=$(tput sgr0)

# TODO Implement a backup with a option which can be enabled via flag - See commented out code

# Creating directories, only if they don't exist.
# echo "\n\n>🎒 Ensuring backup directory is in place. (~/.dotfiles/backup)\n"
# mkdir -p ~/.dotfiles
# mkdir -p ~/.dotfiles/backup

# Setting path to look for files
echo "🗂] Discovering files from present working directory ${bold}$(pwd)${normal}..\n"
FILES=$(pwd)/*;
for filepath in $FILES; do
  # Get the filename from the full path
  filename=${filepath##*/}
  # Replace the first occurance of a _ to a .
  filename=$(echo "$filename" | sed 's/_/./')
  # Skip any file which doesn't start with a `.` post conversion
  if [[ $filename != .*  ]]; then
    echo "⏩ Skipping $filename\n ";
    continue;
  fi

  echo "🗂] \033[0m Discovered: ${bold} $filename ${normal} - $filepath"
  echo "🛑 \033[0;31m ${bold}Removing:   ${normal} ~/$filename"
  sudo rm ~/$filename

  # echo "> Backing up old dotfile ($filename)"
  # sudo mv ~/$filename ~/.dotfiles/backup/$filename

  echo "🔗 Linking: ${bold}$filepath${normal} --> ${bold}~/$filename${normal} file"
  sudo ln -s  $filepath ~/$filename
  echo "------"

  sleep "1";
done