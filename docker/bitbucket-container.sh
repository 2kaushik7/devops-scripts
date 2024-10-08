#!/bin/bash

DIR_PATH="/Users/kaushiksurineedi/bitbucket-data/"
CREATE_BITBUCKET="docker run -d --name bitbucket \
                               -p 7990:7990 -p 7999:7999 \
                               -v /Users/kaushiksurineedi/bitbucket-data:/var/atlassian/application-data/bitbucket \
                               atlassian/bitbucket"

if [ -d "$DIR_PATH" ]; then
  if [ "$(ls -A $DIR_PATH)" ]; then
    echo "Directory '$DIR_PATH' is not empty"
    # Prompt the user for input
    read -p "Do you want the directory empty ? (yes/no): " user_input
    # Convert input to lowercase
    user_input=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')
    # Check user's input
    if [ "$user_input" == "yes" ]; then
        echo  "emptying the directory.."
        # shellcheck disable=SC2115
        rm -rf "$DIR_PATH"/*
        echo "Directory emptied"
        else
          echo "Directory not emptied"
    fi
    else
     echo "Directory '$DIR_PATH' is already empty."
  fi
else
 echo "Directory '$DIR_PATH' does not exist."
fi

create_bitbucket_container () {
  if [ "$(docker ps -q -f name=bitbucket)" ]; then
      read -p "Bitbucket already running , do you want to recreate the container ? (yes/no): " recreate
      recreate=$(echo "$recreate" | tr '[:upper]' '[:lower]')
      if [ "$recreate" == "yes" ]; then
          docker stop bitbucket
          docker rm bitbucket
          eval "$CREATE_BITBUCKET"
      fi
  else
    eval "$CREATE_BITBUCKET"
  fi
}

create_bitbucket_container