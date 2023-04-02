#!/bin/bash

# Check if action argument was provided
if [ $# -ne 1 ]; then
    action='test'
else
    action=$1
fi

# Check if path argument was provided
if [ $# -ne 2 ]; then
    # List existing directories inside ./projects folder
    echo "Select one of the existing projects in ./projects:"

    path_to_check=./projects/$(find ./projects -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | fzf)
else
    path_to_check=$2
fi
echo "Path to check: $path_to_check"
# Check if path exists
if [ ! -d "$path_to_check" ]; then
    echo "Error: Path does not exist"
    exit 1
fi

# Run command inside Docker container
docker exec php_tdd_katas sh -c "cd $path_to_check && composer run $action"
