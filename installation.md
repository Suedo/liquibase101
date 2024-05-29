## Installing DB

1. check docker and docker-compose

```shell
docker --version
Docker version 26.1.2, build 211e74b

docker-compose --version
zsh: command not found: docker-compose
```

I had docker, but not docker-compose, so install in linuxmint:

```sh
sudo curl -L "https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
Docker Compose version v2.27.0
```
