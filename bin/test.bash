#!/bin/bash

source ./bin/setenv.bash

container_name=$PROJECT_NAME"-container"

container_was_not_running_before_execution=$(docker ps | grep $container_name | wc -l)

[[ $container_was_not_running_before_execution -ne 1 ]] && bin/run.bash --detach

docker exec $container_name sh -c "pytest -p no:cacheprovider /home/app/tests/*"

[[ $container_was_not_running_before_execution -ne 1 ]] && docker stop $container_name