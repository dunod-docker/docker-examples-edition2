#!/bin/bash

docker stop centos-test
docker system prune -f

docker run -itd --name centos-test centos:7
