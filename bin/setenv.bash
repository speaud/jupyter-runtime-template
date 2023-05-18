#!/bin/bash

if [ ! -f .env ]; then
    echo "Please create a .env file from the .env.template" && exit 1
else
    source .env
    echo "Environment variables set"
fi