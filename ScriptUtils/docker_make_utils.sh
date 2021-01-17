#!/bin/bash

ACR_NAME=$1
IMAGE_NAME=$2
TAG_NAME=$3

show_help() {
    printf "Usage: <command> options [parameters]\n"
    printf "\n"
    printf "Options: \n"
    printf "  --help | -h, show help \n"
    printf "  options | required - Azure Container Registry(ACR) to push to, name of the docker image to be parsed - ex. <command> mycontainerregistry helloworld \n"
    printf "  [parameters] | optional - tag of the docker image to be parsed - ex. <command> mycontainerregistry helloworld v1 \n"
    printf "\n"
    printf "  NOTE: when entering your Azure Container Registry name, you only need to add the account name. The .azurecr.io is already set. Ex: passing 'mycontainerregistry' to the argument is the same as 'mycontainerregistry.azurecr.io'"
    exit 1
}

throw_missing_image_error() {
    printf "Error: An image name is required. \n"
    show_help
    exit 1
}

throw_missing_acr_error() {
    printf "Error: An Azure Container Registry name is required. \n"
    show_help
    exit 1
}

throw_general_error() {
    printf "Error: An argument must be provided. \n"
    show_help
    exit 1
}

# Build, tag and push to Azure Container Registry
run_acr_build() {
    # If an argument for 'TAG_NAME' is not provided then build the image with the 'latest' tag
    if [[ "$ACR_NAME" != "" && "$IMAGE_NAME" != "" && "$TAG_NAME" == "" ]]; then
        echo "Building image with image name: '$IMAGE_NAME' and tag 'latest'."
        docker build -t $IMAGE_NAME .
        echo "Tagging image '$IMAGE_NAME' with tag 'latest'"
        docker tag $IMAGE_NAME $ACR_NAME.azurecr.io/$IMAGE_NAME
        echo "Pushing image '$IMAGE_NAME' with tag 'latest' to "$ACR_NAME" container registry."
        docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:latest
    # If an argument for 'TAG_NAME' is provided, build and tag the image with the provided tag name
    elif [[ "$ACR_NAME" != "" && "$IMAGE_NAME" != "" && "$TAG_NAME" != "" ]]; then
        echo "Building image with image name: '$IMAGE_NAME' and tag '$TAG_NAME'"
        docker build -t $IMAGE_NAME .
        echo "Tagging image '$IMAGE_NAME' with tag '$TAG_NAME'"
        docker tag $IMAGE_NAME $ACR_NAME.azurecr.io/$IMAGE_NAME:$TAG_NAME
        echo "Pushing image '$IMAGE_NAME' with tag '$TAG_NAME' to Azure Container Registry."
        docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:$TAG_NAME
    # Catch errors
    else
        throw_error
    fi
}

# TODO - Need to find a better way to parse arguments for '-h' or '--help'
if [[ "$IMAGE_NAME" == "-h" || "$IMAGE_NAME" == "--help" ]] || [[ "$TAG_NAME" == "-h" || "$TAG_NAME" == "--help" ]] || [[ "$ACR_NAME" == "-h" || "$ACR_NAME" == "--help" ]]; then
    show_help
# If the ACR or Docker Image argument are empty, throw an error
# If the arguments provided are 0 OR are greater than 3 throw an error
elif [[ $# -gt 3 || $# -eq 0 ]]; then
    throw_general_error
elif [[ -z "$IMAGE_NAME" ]]; then
    throw_missing_image_error
elif [[ -z "$ACR_NAME" ]]; then
    throw_missing_acr_error
else
    run_acr_build
fi
