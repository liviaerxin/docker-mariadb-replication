FROM mariadb:10.1

RUN apt-get update && apt-get install -y vim inetutils-ping

ENV REPLICATION_USER repl_user
ENV REPLICATION_PASSWORD repl_password
ENV MASTER_PORT 3306

COPY init-master.sh /opt/
COPY repl-master.cnf /opt/
COPY init-slave.sh /opt/
COPY repl-slave.cnf /opt/
COPY initdb.d/*.sql /opt/

COPY replication-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/replication-entrypoint.sh

ENTRYPOINT ["replication-entrypoint.sh"]
CMD ["mysqld"]