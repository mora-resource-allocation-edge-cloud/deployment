#!/bin/bash

function change_dir() {
  cd "$1" || exit
}

START_PATH=$(pwd)

change_dir ../../videomanagement
docker build -t aleskandro/video-server:cloud-vms -f Dockerfile.production .

change_dir "$START_PATH"
change_dir ../../videoprocessing
docker build -t aleskandro/video-server:cloud-vps -f Dockerfile .

change_dir "$START_PATH/gateway"
change_dir ../../videoprocessing
docker build -t aleskandro/video-server:cloud-gateway -f Dockerfile .

docker push aleskandro/video-server:cloud-vms
docker push aleskandro/video-server:cloud-vps
docker push aleskandro/video-server:cloud-gateway


