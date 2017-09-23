FROM nginx:latest

ENV WEB_DOMAIN localhost

ENV APP_PROTOCOL http
ENV APP_HOST 127.0.0.1
ENV APP_PORT 5000

ENV HTTPS False
ENV HTTPS_CERT_PUBLIC_PATH ""
ENV HTTPS_CERT_PRIVATE_PATH ""
ENV HTTPS_LETSENCRYPT_EMAIL ""
ENV HTTPS_DHPARAM_LEN 4096

ENV SUPPORTS_WWW_SUBDOMAIN False

VOLUME /etc/letsencrypt

COPY conf/ /etc/nginx/
COPY ./*.sh /root/
RUN chmod +x /root/*.sh

RUN ln -sf /dev/stdout /var/log/nginx/access_reverse_proxy.log \
    && ln -sf /dev/stderr /var/log/nginx/error_reverse_proxy.log

ENTRYPOINT ["/root/run.sh"]
