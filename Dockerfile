FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y lsb-release wget gnupg2
RUN wget -O - 'http://repo.proxysql.com/ProxySQL/repo_pub_key' | apt-key add -
RUN echo deb http://repo.proxysql.com/ProxySQL/proxysql-2.0.x/$(lsb_release -sc)/ ./ \
    | tee /etc/apt/sources.list.d/proxysql.list

RUN apt-get update
RUN apt-get install -y proxysql
RUN apt-get install -y mysql-client

RUN apt-get install -y mc

COPY ./deploy/config/proxysql.cnf /etc/proxysql.cnf

COPY ./deploy/docker-db-entrypoint /usr/local/bin/docker-db-entrypoint
RUN chmod -v -f 755 /usr/local/bin/docker-db-entrypoint


ENTRYPOINT ["docker-db-entrypoint"]
