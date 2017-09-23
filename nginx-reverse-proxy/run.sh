#!/bin/bash

set -e

PROVISIONED_CHECK_FILE=/root/.provisioned

if [ ! -f "$PROVISIONED_CHECK_FILE" ]; then

    # Execute once
    echo "Start provision..."

    if [ "$SUPPORTS_WWW_SUBDOMAIN" = True ]; then
        nginx_domains="www.$WEB_DOMAIN $WEB_DOMAIN"
    else
        nginx_domains=$WEB_DOMAIN
    fi

    sed -i 's|${WEB_DOMAINS}|'"$nginx_domains"'|g' /etc/nginx/conf.d/*
    sed -i 's|${WEB_DOMAIN}|'"$WEB_DOMAIN"'|g' /etc/nginx/conf.d/*
    sed -i 's|${APP_PROTOCOL}|'"$APP_PROTOCOL"'|g' /etc/nginx/conf.d/*
    sed -i 's|${APP_HOST}|'"$APP_HOST"'|g' /etc/nginx/conf.d/*
    sed -i 's|${APP_PORT}|'"$APP_PORT"'|g' /etc/nginx/conf.d/*

    # Create content root directory for e.g. letsencrypt
    mkdir -p /var/www/"$WEB_DOMAIN"

    nginx -g "daemon on;"

    if [ "$HTTPS" = True ]; then
        bash /root/https-certs-handler.sh
    fi

    printf "# DO NOT EDIT OR REMOVE\n# This file indicates Docker container is provisioned\n" > "$PROVISIONED_CHECK_FILE"
    
    echo "Stopping nginx daemon..."
    nginx -s quit
    PID=$(cat /var/run/nginx.pid)
    while [ -d "/proc/$PID" -a -f /var/run/nginx.pid ]; do
        sleep 1
    done
    echo "Stopping nginx daemon...done"
    
    echo "Provision is finished"
fi

echo "Starting NGINX..."
nginx -g "daemon off;"
