# Useful Docker Commands

## Docker PS (list running containers)
`docker ps`

## Interactive Session for running containers
`docker exec -it <mycontainer> bash`

## Copy files from running container
`docker cp <containerId>:/file/path/within/container /host/path/target`
