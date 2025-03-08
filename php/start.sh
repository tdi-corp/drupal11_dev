#!/bin/bash
shopt -s extglob
set -e
#chown -R www-data:www-data /var/www/html/!(.git)
service cron start
exec $@