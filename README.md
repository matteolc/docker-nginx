# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for [Nginx](https://nginx.org/en/) in SSL mode and with [NGINX Amplify](https://amplify.nginx.com) enabled.

[NGINX Amplify](https://amplify.nginx.com/signup/) is a free monitoring tool that can be used with a microservice architecture based on NGINX and Docker. Amplify is developed and maintained by Nginx Inc. — the company behind the NGINX software.

With Amplify it is possible to collect and aggregate metrics across Docker containers, and present a coherent set of visualizations of the key NGINX performance data, such as active connections or requests per second. It is also easy to quickly check for any performance degradations, traffic anomalies, and get a deeper insight into the NGINX configuration in general.

![](amplify.png?raw=true "Amplify dashboard")

# Getting started

Unless already done, you have to [sign up](https://amplify.nginx.com/signup/), create an account in NGINX Amplify, and obtain a valid API key.

Execute `run.sh` after setting the environment variable AMPLIFY_KEY to your Amplify key.

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/voxbox/nginx/) and is the recommended method of installation.

```bash
docker pull voxbox/nginx:latest
```

Alternatively you can build the image yourself.

```bash
docker build -t nginx github.com/matteolc/docker-nginx
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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/docker-nginx. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The container is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the T2Airtime project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/docker-nginx/blob/master/CODE_OF_CONDUCT.md).

