#!/bin/bash

source ./bin/setenv.bash

docker build $@\
    --tag $PROJECT_NAME .