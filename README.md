# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for development of a [Rails](http://rubyonrails.org/) application.

See the `Dockerfile` for further details on how the application is bootstrapped.

The image is based on [Debian Jessie](https://www.debian.org/).

# Getting started

Execute `run.sh`

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/voxbox/rails-api/) and is the recommended method of installation.

```bash
docker pull voxbox/rails-api:latest
```

Alternatively you can build the image yourself.

```bash
docker build -t voxbox/postgresql github.com/matteolc/docker-rails-api
```

## Quickstart

Use the sample [docker-compose.yml](docker-compose.yml) to start the container using [Docker Compose](https://docs.docker.com/compose/)*

All examples use named volumes (not bind mounts). You can change the local driver to a more performant one, such as [overlay](https://docs.docker.com/engine/userguide/storagedriver/overlayfs-driver/#configure-docker-with-the-overlay-or-overlay2-storage-driver).

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec` against the running container.

## Issues

Before reporting your issue please try updating Docker to the latest version and check if it resolves the issue. Refer to the Docker [installation guide](https://docs.docker.com/installation) for instructions.

SELinux users should try disabling SELinux using the command `setenforce 0` to see if it resolves the issue.

If the above recommendations do not help then [report your issue](../../issues/new) along with the following information:

- Output of the `docker vers6` and `docker info` commands
- The `docker run` command or `docker-compose.yml` used to start the image. Mask out the sensitive bits.
- Please state if you are using [Boot2Docker](http://www.boot2docker.io), [VirtualBox](https://www.virtualbox.org), etc.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/t2_airtime. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The container is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the T2Airtime project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/t2_airtime/blob/master/CODE_OF_CONDUCT.md).

