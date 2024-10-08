#!/bin/zsh

#stop all running containers
if [ "$(docker ps -a -q)" ]; then
  echo "Stopping all containers"
  docker stop $(docker ps -a -q)
else
  echo "No containers to stop."
fi

#remove all containers
if [ "$(docker ps -a -q)" ];then
  echo "Removing all containers"
  docker rm $(docker ps -a -q)
else
  echo "No containers to remove"
fi