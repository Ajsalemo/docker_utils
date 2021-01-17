# script_utils
Bash scripts to condense and/or automate repitive local tasks.
<br>

----

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

<br>

----
### git_push_utils.sh
A script made to automate pushing git commits.
<br>
#### Usage
```<command> options [parameters]```<br>
```-h``` | ```--help``` - show help <br>
The command requires a minimum of two arguments, which is the commit message(arg: 1) and upstream repo(arg: 2). Omitting the third argument which is the branch(arg: 3) will default to 'main'.

Example: ```bash git_push_utils.sh 'my first commit' origin```
This is the equivalent to: <br>
```git add . ```<br>
```git commit -m 'my first commit'```<br>
```git push origin main```

<b>Note</b>: The commit message must be in a string unless using only a single word for the commit message.

How it looks when specifying a branch. Example: ```bash git_push_utils.sh 'my first commit' origin dev```
This is the equivalent to: <br>
```git add . ```<br>
```git commit -m 'my first commit'```<br>
```git push origin dev```
<br>
<br>
As mentioned above, this script can be aliased within your ```.bashrc``` and script location added to your PATH so it can be executed globally. <br>
Aliased example, where ```gutils``` is the script alias name: ```gutils 'initial commit' origin testing```
