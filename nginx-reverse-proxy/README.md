Basic NGINX reverse proxy container with HTTPS support and LetsEncrypt support

Run example:
```
docker run \
       -p 80:80 \
       -e "WEB_DOMAIN=my.host.com" \
       -e "APP_HOST=backend.domain" \
       --name nginx \
       nazar89/nginx-reverse-proxy
```

Docker container can be controlled via environment variables:
* WEB_DOMAIN - contains domain name of site/service (e.g. company.com).
* APP_PROTOCOL - http or https protocol of connection to proxied backend (default http).
* APP_HOST - host/ip of proxied backend (default is localhost).
* APP_PORT - port of proxied backend (default is 5000).
* HTTPS - True/False, support https or not (default False).
* HTTPS_CERT_PUBLIC_PATH & HTTPS_CERT_PRIVATE_PATH - should be defined in case of HTTPS is True and you have SSL certificates. You should skip this variables if you want to use LetsEncrypt.
* HTTPS_LETSENCRYPT_EMAIL - should be defined in case of HTTPS is True and you want to use LetsEncrypt.
* HTTPS_DHPARAM_LEN - length of auto-generated dhparam file of nginx (default is 4096).
* SUPPORTS_WWW_SUBDOMAIN - True/False, set it True is you want to generate handle requests to www.WEB_DOMAIN (default is False).
