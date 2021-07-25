#!/bin/bash
set eux pipefail

scp flask/* ${LINODE_USER}@${LINODE_IP}:/home/app
scp uwsgi/* ${LINODE_USER}@${LINODE_IP}:/home/app
scp nginx/* ${LINODE_USER}@${LINODE_IP}:/home/app

# Sticking everything in one folder was a great decision
scp flask/requirements.txt ${LINODE_USER}@${LINODE_IP}:/home/app/requirements-flask.txt
scp uwsgi/requirements.txt ${LINODE_USER}@${LINODE_IP}:/home/app/requirements-uwsgi.txt
