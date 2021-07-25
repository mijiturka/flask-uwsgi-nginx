#!/bin/bash
set eux pipefail

apt-get -y update && apt-get -y upgrade
apt-get -y install python3 python3-pip
apt-get -y install curl
apt-get -y install nginx

pushd ../app

pip3 install -r requirements-flask.txt

pip3 install -r requirements-uwsgi.txt

/bin/bash nginx.sh

nginx
uwsgi --socket 0.0.0.0:$FLASK_PORT settings.ini

popd
