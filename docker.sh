#!/bin/bash

tag=0.2

build() {
  docker build -f ./Dockerfile -t env_ede:$tag .
  docker run -it --privileged -v /home:/home -v /dev/bus/usb:/dev/bus/usb --name env_ede env_ede:$tag
};

remove() {
  if [[ -n $(sudo docker ps -q -f "name=^env_ede$") ]];then
    docker stop env_ede
  fi
  docker rm env_ede
  docker rmi env_ede:$tag
}

if [ $1 == "build" ]
then
  build
elif [ $1 == "remove" ]
then
  remove
else
  echo "没有符合的命令"
fi

