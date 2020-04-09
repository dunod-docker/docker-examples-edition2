#!/bin/bash

docker stop centos-test-1
docker stop centos-test-2
docker system prune -f
