#!/bin/bash

COMMIT_MESSAGE=$1
SPECIFY_BRANCH=$2

echo "$COMMIT_MESSAGE"
echo "$SPECIFY_BRANCH"

throw_missing_commit_error() {
    printf "Error: the commit message can not be empty. \n"
    show_help
    exit 1
}

show_help() {
    printf "Usage: <command> options [parameters] \n"
    printf "\n"
    printf "Options: \n"
    printf "  --help | -h, show help \n"
    printf "  options | required - A commit message to use with git. \n"
    printf "  parameters | optional - The target branch to push to. If omitted, this defaults to 'main'. \n"
    printf "  Example: <command> 'this is my first commit' main \n"
    printf "  This is the equivalent of: \n"
    printf "  git add . \n"
    printf "  git commit -m 'this is my first commit' \n"
    printf "  git push origin main"
    exit 1
}

if [[ "$COMMIT_MESSAGE" == "-h" || "$COMMIT_MESSAGE" == "--help" ]] || [[ "$SPECIFY_BRANCH" == "-h" || "$SPECIFY_BRANCH" == "--help" ]]; then
    show_help
fi
