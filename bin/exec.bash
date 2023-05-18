#!/bin/bash

source ./bin/setenv.bash

docker exec \
    --interactive \
    --tty \
    $PROJECT_NAME-container bash
