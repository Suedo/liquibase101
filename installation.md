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

## Installing liquibase

[Liquibase Releases](https://github.com/liquibase/liquibase/releases)
At the time of writting, latest is 4.28

1. download tar file from here: https://github.com/liquibase/liquibase/releases/tag/v4.28.0
2. extract into a suitable place
3. update zshrx (or bashrc) path:
```sh
export PATH=$PATH:/path/to/your/liquibase-4.28.0
```
4. source the rc file for path update to take place
5. do `liquibase -h` in terminal, should show data.

### Requirement if using MySQL 

By default, liquibase doesn't ship with mysql jar in its lib.
https://docs.liquibase.com/start/tutorials/mysql.html
To use Liquibase and MySQL, you need the JDBC driver JAR file (Maven download).
To use the Liquibase CLI, place your JAR file(s) in the liquibase/lib directory.
