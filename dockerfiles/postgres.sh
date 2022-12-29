#!/bin/bash

# Build an image from the Dockerfile and assign it a name
docker build -t eg_postgresql ./postgres

# Run the PostgreSQL server container (in the foreground)
docker run --rm -P -d --name postgresql_docker eg_postgresql

