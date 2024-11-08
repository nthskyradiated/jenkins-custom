## custom Jenkins image with sudo privileges and docker client pre-installed

* ### running the container in powershell:
```powershell
#create network first:
docker network create jenkins

#run DinD:

docker run --name docker-dind --rm -d `
  --privileged `
  --network jenkins `
  --network-alias docker `
  --env DOCKER_TLS_CERTDIR=/certs `
  --mount type=bind,src=C:\DockerCerts,target=/certs `
  --publish 2376:2376 `
  docker:dind --storage-driver overlay2
```
```powershell

docker run --name jenkins-custom --rm -d `
  --network jenkins `
  --env DOCKER_HOST=tcp://docker:2376 `
  --env DOCKER_TLS_CERTDIR=/certs `
  --publish 8080:8080 `
  --mount type=bind,src=C:\DockerCerts,target=/certs `
  --mount type=volume,src=jenkins-data,dst=/var/jenkins_home `
  your-registry/jenkins-custom
```
### or
```powershell
docker run --name jenkins-custom --rm --detach `
    --network jenkins `
    --mount type=volume,source=jenkins-data,target=/var/jenkins_home `
    --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock `
    --publish 8080:8080 --publish 50000:50000 `
    your-registry/jenkins-custom

```

### or in git bash for windows:
```bash
#make sure the source mount exists (the bind mount looks funny since I'm using git bash)
docker run --name jenkins-custom --rm --detach \
    --network jenkins \
    --mount type=bind,source=//c/dockermounts/jenkinsmount,target=/var/jenkins_home \
    --mount type=bind,source=//var/run/docker.sock,target=/var/run/docker.sock \
    --publish 8080:8080 --publish 50000:50000 \
    your-registry/jenkins-custom

## Add this flag if you want to expose the docker daemon to the Jenkins container:
## Make sure it is enabled in Docker desktop
    -e DOCKER_HOST=tcp://host.docker.internal:2375

```
