#!/bin/bash
set -eux pipefail

TARGET_DIR="/server"
SETUP_DIR="/setup"

ssh ${LINODE_USER}@${LINODE_IP} "mkdir -p ${TARGET_DIR} ${SETUP_DIR}"

scp -r ../deploy $LINODE_USER@$LINODE_IP:${SETUP_DIR}

scp -r ../server/* ${LINODE_USER}@${LINODE_IP}:${TARGET_DIR}
