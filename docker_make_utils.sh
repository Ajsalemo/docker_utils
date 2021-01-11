#!/bin/bash

IMAGE_NAME=$1
TAG_NAME=$2
ACR_NAME="ansalemocontainerregistry.azurecr.io"

show_help() {
    printf "Usage: <command> options [parameters]\n"
    printf "\n"
    printf "Options: \n"
    printf "  --help | -h, show help \n"
    printf "  options | required - name of the docker image to be parsed - ex. <command> helloworld \n"
    printf "  [parameters] | optional - tag of the docker image to be parsed - ex. <command> helloworld v1 \n"
}

throw_error() {
    printf "Error: An image name is required. \n"
    show_help
    exit 1
}

# Build, tag and push to Azure Container Registry
run_acr_build() {
    # If an argument for 'TAG_NAME' is not provided then build the image with the 'latest' tag
    if [[ "$IMAGE_NAME" != "" && "$TAG_NAME" == "" ]]; then
        echo "Building image with image name: '$IMAGE_NAME' and tag 'latest'."
        docker build -t $IMAGE_NAME .
        echo "Tagging image '$IMAGE_NAME' with tag 'latest'"
        docker tag $IMAGE_NAME $ACR_NAME/$IMAGE_NAME
    # If an argument for 'TAG_NAME' is provided, build and tag the image with the provided tag name
    elif [[ "$IMAGE_NAME" != "" && "$TAG_NAME" != "" ]]; then
        echo "Building image with image name: '$IMAGE_NAME' and tag '$TAG_NAME'"
        docker build -t $IMAGE_NAME .
        echo "Tagging image '$IMAGE_NAME' with tag '$TAG_NAME'"
        docker tag $IMAGE_NAME $ACR_NAME/$IMAGE_NAME:$TAG_NAME 
    # Catch errors
    else
        throw_error
    fi
}

if [[ "$IMAGE_NAME" == "-h" || "$IMAGE_NAME" == "--help" ]] || [[ "$TAG_NAME" == "-h" || "$TAG_NAME" == "--help" ]]; then
    show_help
# If the image name argument is then throw an error
# If the arguments provided are 0 OR are greater than 2 throw an error
elif [[ "$IMAGE_NAME" == "" ]] ||  [[ $# -gt 2 || $# -eq 0 ]]; then
    throw_error
else 
    run_acr_build
fi
