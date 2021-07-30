#!/bin/bash

set -eux pipefail

sed -i "s/{{FLASK_PORT}}/${FLASK_PORT}/g" settings.conf
cp settings.conf /etc/nginx/sites-enabled/app
touch /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-enabled/default
service nginx reload || nginx
