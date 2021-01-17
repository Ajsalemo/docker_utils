# script_utils
Bash scripts to condense and/or automate repitive local tasks.

### docker_make_utils.sh
A script made to automate the task of building, tagging and pushing local Docker images to Azure Container Registry(ACR).
<br>
#### Usage
```<command> options [parameters]```<br>
```-h``` | ```--help``` - show help 

Example. ```bash docker_make_utils.sh mycontainerregistry helloworld```
This is the equivalent to: <br>
```docker build -t helloworld . ```<br>
```docker tag helloworld mycontainerregistry.azurecr.io/helloworld:latest```<br>
```docker push mycontainerregistry.azurecr.io/helloworld:latest```

<b>Note:</b> If omitting the tag for the image, this will default to latest. A tag can be supplied as the 3rd argument, as seen in an example below: <br>
```bash docker_make_utils.sh mycontainerregistry helloworld v1``` <br>
This is the equivalent to: <br>
```docker build -t helloworld . ```<br>
```docker tag helloworld mycontainerregistry.azurecr.io/helloworld:v1```<br>
```docker push mycontainerregistry.azurecr.io/helloworld:v1```
<br>
<br>
<b>Note:</b> You must still log in with either AZ CLI and run ```docker login``` before pushing to the container registry for the first time, if not authenticated already. <br> 
<b>Tip:</b> Bash scripts can be aliased locally - by editing the ```.bashrc``` file and adding the script location to your PATH to run this globally. Doing so then can have the script be run in the following manner(where ```dutils``` is the alias name): ```dutils mycontainerregistry helloworld v1```
