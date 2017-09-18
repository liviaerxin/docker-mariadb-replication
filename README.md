# Docker image for Mariadb that supports master-slave replication

# 1. Build image

```
docker build -t test/mariadb2 .
```

or

```
./build.sh
```

# 2. Run as single mariadb

```
docker run -d \
  --name mariadb2 \
  -v /tmp/database=/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=passw0rd \
  -e MYSQL_DATABASE=DPMS \
  -e MYSQL_USER=test_write \
  -e MYSQL_PASSWORD=test_write \
  test/mariadb2
```

# 3. Run as master-slave replication

## Start master

```
docker run -d \
  --name mariadb2_master \
  -v /tmp/database-master=/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=passw0rd \
  -e MYSQL_DATABASE=DPMS \
  -e MYSQL_USER=test_write \
  -e MYSQL_PASSWORD=test_write \
  -e REPLICATION_MODE=master \
  -e REPLICATION_USER=repl_user \
  -e REPLICATION_PASSWORD=repl_password \
  test/mariadb2
```

## Start slave

```
docker run -d \
  --name mariadb2_slave \
  -v /tmp/database-slave=/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=passw0rd\
  -e MYSQL_DATABASE=DPMS \
  -e MYSQL_USER=test_write \
  -e MYSQL_PASSWORD=test_write \
  -e REPLICATION_MODE=slave \
  -e REPLICATION_USER=repl_user \
  -e REPLICATION_PASSWORD=repl_password \
  -e MASTER_HOST=master \
  -e MASTER_PORT=3306 \
  --link mariadb2_master:master \
  test/test/mariadb2
```

# 4. Use docker stack

```
docker stack deploy replication -c docker-stack-replication.yml
```

or

```
docker stack deploy single -c docker-stack.yml
```
