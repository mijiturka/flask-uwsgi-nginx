Basic Flask setup with uWSGI and NGINX

* Docker for local development
* Straight on server for deployment

Meant for deployment on Linode; some bash scripts currently provided - may include some fancier infrastructure-as-code later

Draws inspiration from
* https://github.com/abalarin/Flask-on-Linode
* https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-xvii-deployment-on-linux
* https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html
* https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uwsgi-and-nginx-on-ubuntu-20-04

Why uWSGI over e.g gunicorn?
* It's faster and more reliable: https://blog.kgriffs.com/2012/12/18/uwsgi-vs-gunicorn-vs-node-benchmarks.html

# Deploy locally

## Build
```
$ sudo docker build -t server_image .
```

Or, to set the port:
```
$ sudo docker build -t --build-arg FLASK_PORT=6000 server_image .
```

## Run
```
$ sudo docker rm server && sudo docker run --name server -it server_image
```

## Test
```
$ sudo docker exec -it server /bin/bash
# curl localhost:8000
You reached it!!!
```

# Deploy on Linode

Try this out and use it as a basis for fancier infrastructure configuration in the future...

on local:
```
$ export LINODE_USER=<user>
$ export LINODE_IP=<ip>
$ bash deploy/copy.sh
```

on node:
```
$ export FLASK_PORT=8000
$ cd ~/deploy
$ bash configure.sh
```

## Test
```
$ curl http://$LINODE_IP/
```
