#!/bin/bash

docker stop busybox-1
docker stop busybox-2
docker stop busybox-3
docker system prune -f
