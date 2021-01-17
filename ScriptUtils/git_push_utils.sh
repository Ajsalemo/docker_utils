#!/bin/bash

COMMIT_MESSAGE=$1
SPECIFY_UPSTREAM=$2
SPECIFY_BRANCH=$3

echo "$COMMIT_MESSAGE"
echo "$SPECIFY_BRANCH"

throw_missing_commit_error() {
    printf "Error: the commit message can not be empty. \n"
    show_help
    exit 1
}

throw_missing_upstream_error() {
    printf "Error: an upstream target must be provided. \n"
    show_help
    exit 1
}

throw_general_error() {
    printf "Error: an unexpected error as occurred."
    exit 1
}

show_help() {
    printf "Usage: <command> options [parameters] \n"
    printf "\n"
    printf "Options: \n"
    printf "  --help | -h, show help \n"
    printf "  options | required - A commit message to use with git. \n"
    printf "  parameters | optional - The remote upstream to push to. If omitted, this defaults to 'origin'. \n"
    printf "  parameters | optional - The target branch to push to. If omitted, this defaults to 'main'. \n"
    printf "  Example: <command> 'this is my first commit' origin main \n"
    printf "  This is the equivalent of: \n"
    printf "  git add . \n"
    printf "  git commit -m 'this is my first commit' \n"
    printf "  git push origin main"
    exit 1
}

run_git_commit() {
    if [[ -z "$SPECIFY_BRANCH" && "$SPECIFY_UPSTREAM" ]]; then
        echo "Pushing to default branch 'main' to default upstream 'origin'."
        git add .
        git commit -m "$COMMIT_MESSAGE"
        git push origin main
    elif [[ ! -z "$SPECIFY_UPSTREAM" && ! -z "$SPECIFY_BRANCH" ]]; then
        echo "Pushing to branch '$SPECIFY_BRANCH' and upstream '$SPECIFY_UPSTREAM'."
        git add .
        git commit -m "$COMMIT_MESSAGE"
        git push $SPECIFY_UPSTREAM $SPECIFY_BRANCH
    elif [[ -z "$SPECIFY_UPSTREAM" ]]; then
        throw_missing_upstream_error
    fi
}

# If any of the arguments supplied have '-h' or '--help' then display the 'show_help' function
if [[ "$COMMIT_MESSAGE" == "-h" || "$COMMIT_MESSAGE" == "--help" ]] || [[ "$SPECIFY_BRANCH" == "-h" || "$SPECIFY_BRANCH" == "--help" ]] || [[ "$SPECIFY_UPSTREAM" == "-h" || "$SPECIFY_UPSTREAM" == "--help" ]]; then
    show_help
# If the commit message is missing then thrown an error
elif [[ -z "$COMMIT_MESSAGE" ]]; then
    throw_missing_commit_error
# If the commit message is supplied then run the git push function
elif [[ ! -z "$COMMIT_MESSAGE" ]]; then
    run_git_commit
# Throw an error if none of the above apply
else
    throw_general_error
fi
