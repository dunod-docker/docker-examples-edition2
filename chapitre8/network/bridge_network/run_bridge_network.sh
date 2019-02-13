#!/bin/bash

docker stop centos-test-1
docker stop centos-test-2
docker system prune -f

docker run -itd --name centos-test-1 centos:7
docker run -itd --name centos-test-2 centos:7