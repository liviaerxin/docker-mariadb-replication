#!/bin/bash
set -eo pipefail

export SERVER_ID=1

if [[ -n $REPLICATION_MODE ]]; then
  # master-slave replication mode
  case $REPLICATION_MODE in
    master)
      cp -v /opt/init-master.sh /docker-entrypoint-initdb.d/
      cp -v /opt/*.sql /docker-entrypoint-initdb.d/
      cp -v /opt/repl-master.cnf /etc/mysql/conf.d/
      ;;
    slave)
      SERVER_ID=$[$REPLICATION_ID*10]
      cp -v /opt/init-slave.sh /docker-entrypoint-initdb.d/
      cp -v /opt/repl-slave.cnf /etc/mysql/conf.d/
      ;;
    *)
      echo "UNKNOWN REPLICATION_MODE: ${REPLICATION_MODE}"
      exit 1
  esac
else
  # single mode
  cp -v /opt/*.sql /docker-entrypoint-initdb.d/
fi

cat > /etc/mysql/conf.d/server-id.cnf << EOF
[mysqld]
server-id=$SERVER_ID
EOF

exec docker-entrypoint.sh "$@"
