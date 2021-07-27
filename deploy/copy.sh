#!/bin/bash
set eux pipefail

TARGET_DIR="/home/${LINODE_USER}/app"
SETUP_DIR="/home/${LINODE_USER}/setup"

ssh ${LINODE_USER}@${LINODE_IP} "mkdir -p ${TARGET_DIR} ${SETUP_DIR}"

scp -r ../deploy $LINODE_USER@$LINODE_IP:${SETUP_DIR}

scp flask/* ${LINODE_USER}@${LINODE_IP}:${TARGET_DIR}
scp uwsgi/* ${LINODE_USER}@${LINODE_IP}:${TARGET_DIR}
scp nginx/* ${LINODE_USER}@${LINODE_IP}:${TARGET_DIR}

# Sticking everything in one DIR was a great decision
scp flask/requirements.txt ${LINODE_USER}@${LINODE_IP}:${TARGET_DIR}/requirements-flask.txt
scp uwsgi/requirements.txt ${LINODE_USER}@${LINODE_IP}:${TARGET_DIR}/requirements-uwsgi.txt
