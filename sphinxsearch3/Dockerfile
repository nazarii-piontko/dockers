FROM ubuntu:latest

COPY sphinx.conf /etc/sphinx/sphinx.conf
COPY *.sh /usr/bin/

RUN apt-get update -y && apt-get install -y wget mysql-client libmysqlclient-dev && \
    wget -O sphinx.tar.gz http://sphinxsearch.com/files/sphinx-3.0.3-facc3fb-linux-amd64-glibc2.12.tar.gz && \
    tar -zxf sphinx.tar.gz && rm sphinx.tar.gz && \
    mv sphinx-3.0.3/bin/* /usr/bin && \
    rm -rf sphinx-3.0.3 && \
    chmod a+x /usr/bin/run-searchd.sh /usr/bin/run-indexer.sh /usr/bin/entrypoint.sh


VOLUME [ "/etc/sphinx", "/var/data", "/var/log/sphinx" ]

EXPOSE 9312
EXPOSE 9306

ENTRYPOINT [ "entrypoint.sh" ]