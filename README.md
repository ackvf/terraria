## Motivation

Having used other Dockerized dedicated Terraria servers before, it was always immensely painful having to reinstall images and recreate containers from scratch whenever new Terraria version was released - and now multiply the pain by number of running instances...  
I was certain that it should be possible to make this flow easier.  
This here is my attempt at that.

No longer it is necessary to fetch an updated docker image for every new terraria server version - this image is a mere shell for the underlying bash scripts which do all the magic.  
Everything is controlled by environment variables.  
Clean and simple.

### Credits

This project was created by modifying:
- https://github.com/ryansheehan/terraria
- https://github.com/beardedio/terraria



# Getting started

## Configuring the server
*note: Whenever you restart the server container, it downloads new zip from terraria website.*

  - [Generic GUI guide](guides/SynologyNAS/README.md) *<- recommended*
  - [Running on Synology NAS](guides/SynologyNAS/README.md)


## Updating Terraria server version

- Adjust `DOWNLOAD_VERSION` to current latest version e.g. `1446-fixed` and **restart** the container.  
  *Find latest version on [terraria.org](https://terraria.org/) at the bottom "PC Dedicated Server". The version name corresponds to the downloaded file `terraria-server-1446-fixed.zip`.*


## Development

  - [Dockerfile](#dockerfile)
    - [`run`](#cli-docker-run)
    - [`build`](#cli-docker-build)
    - [useful commands](#useful-commands)
  - [Publishing](#publishing)



# Development

See [package.json](package.json) for available tasks.

During script development, it is useful to use `set -euxo pipefail`. Read more [here](https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425).


## `Dockerfile`

The flow is: **source** -> `docker build` -> **image** -> `docker run` -> **container**

1. Build an image locally `npm run build`
2. Start a container `npm start`

### CLI `docker run`
- https://docs.docker.com/engine/reference/commandline/run/
```
--entrypoint        Overwrite the default ENTRYPOINT of the image. e.g. --entrypoint bash
--env , -e          Set environment variables
--env-file          Read in a file of environment variables
--interactive , -i  Keep STDIN open even if not attached
--mount             Attach a filesystem mount to the container
--name              Assign a name to the container
--publish , -p      Publish container's port(s) to the host, e.g. -p 7777:7777 where external:internal
                    external can be anything and unique for each server
--rm                Automatically remove the container when it exits (useful during development)
```
```
-it                 Allocate pseudo-TTY connected to the container's stdin; creating an interactive bash shell in the container
```

### CLI `docker build`
- https://docs.docker.com/engine/reference/commandline/build/
```
--tag , -t              Name and optionally a tag in the 'name:tag' format
--rm                    Remove intermediate containers after a successful build (default: true)
```



## Useful commands

Start container with "Choose world" interactive prompt.

```
docker run --rm --name terraria -it --entrypoint bash -i -e FILENAME_WORLD= -p 7777:7777 ackvf/terraria
```



## Publishing

1. Make sure to be logged in
    ```
   docker login
    ```
2. Push
   ```
    npm run push
   ```
