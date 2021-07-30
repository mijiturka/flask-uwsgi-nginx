#!/bin/bash
set -eux pipefail

TARGET_DIR="/server"

apt-get -y update && apt-get -y upgrade
apt-get -y install python3 python3-pip
apt-get -y install curl nano
apt-get -y install nginx

pushd $TARGET_DIR

pip3 install -r app/requirements.txt
pip3 install -r uwsgi/requirements.txt

pushd nginx
/bin/bash configure.sh
popd

uwsgi --socket 0.0.0.0:$FLASK_PORT uwsgi/settings.ini

popd

service nginx reload || nginx
