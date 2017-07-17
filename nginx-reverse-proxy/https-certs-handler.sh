#!/bin/bash

set -e

NGINX_CONF_FILE=/etc/nginx/conf.d/reverse-proxy.conf
LETSENCRYPT_CRON_FILE=/etc/cron.d/letsencrypt-cron

if [ ! -z "$HTTPS_CERT_PUBLIC_PATH" ] && [ ! -z "$HTTPS_CERT_PRIVATE_PATH" ]; then
    
    # Existing certificate. Set it into config file.
 
    sed -i 's|${SSL_CERTIFICATE}|'"$HTTPS_CERT_PUBLIC_PATH"'|g' "$NGINX_CONF_FILE"
    sed -i 's|${SSL_CERTIFICATE_KEY}|'"$HTTPS_CERT_PRIVATE_PATH"'|g' "$NGINX_CONF_FILE"

elif [ ! -z "$HTTPS_LETSENCRYPT_EMAIL" ]; then

    # Install and Generate/Renew LetsEncrypt certificate.

    echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list
    apt-get update -y
    apt-get install -y --no-install-recommends certbot

    if [ ! -d "/etc/letsencrypt/live'/"$WEB_DOMAIN"'" ]; then
        letsencrypt certonly \
                    --webroot -w "/var/www/"$WEB_DOMAIN"" \
                    -d "$WEB_DOMAIN" -d "www.""$WEB_DOMAIN" \
                    --email "$LETSENCRYPT_EMAIL" \
                    --agree-tos
    else
        letsencrypt renew
    fi

    sed -i 's|${SSL_CERTIFICATE}|/etc/letsencrypt/live/'"$WEB_DOMAIN"'/fullchain.pem|g' "$NGINX_CONF_FILE"
    sed -i 's|${SSL_CERTIFICATE_KEY}|/etc/letsencrypt/live/'"$WEB_DOMAIN"'/privkey.pem|g' "$NGINX_CONF_FILE"

    # Set letsencrypt renew crontab
    apt-get install -y --no-install-recommends cron
    printf "0 1 * * * letsencrypt renew --post-hook 'nginx -s reload'\n" > "$LETSENCRYPT_CRON_FILE"
    chmod 0644 "$LETSENCRYPT_CRON_FILE"
    crontab "$LETSENCRYPT_CRON_FILE"

else

    echo "Invalid HTTPS settings"
    exit 1

fi

# Generate dhparams if missing
if [ ! -f "/etc/nginx/dhparams" ]; then
    openssl dhparam -out /etc/nginx/dhparam "$HTTPS_DHPARAM_LEN"
fi

# Patch nginx conf file for HTTPS
sed -i 's|80; # ||g' "$NGINX_CONF_FILE"
sed -i 's|# ||g' "$NGINX_CONF_FILE"

# Update nginx configuration
nginx -s reload
