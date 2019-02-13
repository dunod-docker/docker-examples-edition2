#!/bin/bash

docker stop busybox-1
docker stop busybox-2
docker stop busybox-3
docker system prune -f

docker network create test

docker run -itd --name busybox-1 --net test busybox
docker run -itd --name busybox-2 --net test busybox
docker run -itd --name busybox-3 busybox