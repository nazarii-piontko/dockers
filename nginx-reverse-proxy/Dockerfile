FROM nginx:latest

RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get install -y python-certbot-apache

ENV HTTPS False
ENV WEB_DOMAIN domain.com
ENV APP_PROTOCOL http
ENV APP_HOST 127.0.0.1
ENV APP_PORT 5000

VOLUME /etc/letsencrypt

COPY conf/nginx.conf /etc/nginx/
COPY conf/conf.d/* /etc/nginx/conf.d/
COPY ./run.sh /
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
