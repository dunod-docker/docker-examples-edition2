#!/bin/bash

docker stop $(docker ps -a -q)
docker system prune --volumes

