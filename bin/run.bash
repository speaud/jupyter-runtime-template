#!/bin/bash

source ./bin/setenv.bash

docker run \
    --rm \
    --publish $JUPYTER_HOST_PORT:8888 \
    --volume $(pwd):/home/app/data \
    --volume $(pwd):/home/app \
    --volume $(pwd)/notebooks:/home/jovyan/notebooks \
    --env-file .env \
    --user root \
    --name $PROJECT_NAME-container \
    $PROJECT_NAME
