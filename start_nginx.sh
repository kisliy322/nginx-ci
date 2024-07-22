#!/bin/bash
docker run -d -p 9889:80 --name nginx-container nginx-ci-example:latest
