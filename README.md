Basic Flask setup with uWSGI and NGINX

* Docker for local development
* Straight on server for deployment

Meant for deployment on Linode; may include some infrastructure-as-code later

Draws inspiration from
* https://github.com/abalarin/Flask-on-Linode
* https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-xvii-deployment-on-linux

Why uWSGI over e.g gunicorn?
* It's faster and more reliable: https://blog.kgriffs.com/2012/12/18/uwsgi-vs-gunicorn-vs-node-benchmarks.html

# Locally

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
