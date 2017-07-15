#!/bin/bash

sed -i 's|${WEB_DOMAIN}|'"$WEB_DOMAIN"'|g' /etc/nginx/conf.d/*
sed -i 's|${APP_PROTOCOL}|'"$APP_PROTOCOL"'|g' /etc/nginx/conf.d/*
sed -i 's|${APP_HOST}|'"$APP_HOST"'|g' /etc/nginx/conf.d/*
sed -i 's|${APP_PORT}|'"$APP_PORT"'|g' /etc/nginx/conf.d/*

nginx -g "daemon off;"
