FROM debian:10

RUN apt-get update && apt-get upgrade
RUN apt-get -y install python3 python3-pip
# Not required, but convenient for testing
RUN apt-get -y install curl

WORKDIR /server

COPY server/app/ ./app
RUN pip3 install -r app/requirements.txt

ARG FLASK_PORT=8000
ENV FLASK_PORT=$FLASK_PORT

# Just run a shell
# CMD ["/bin/bash"]


# Run Flask directly
# ENV FLASK_APP=app/main.py
# CMD flask run --port $FLASK_PORT


# Run via uWSGI
COPY server/uwsgi/ ./uwsgi
RUN pip3 install -r uwsgi/requirements.txt

# Run via uWSGI directly
# CMD uwsgi --protocol http --socket 0.0.0.0:$FLASK_PORT uwsgi/settings.ini


# Run via NGINX
COPY server/nginx/ ./nginx
WORKDIR ./nginx
RUN apt-get -y install nginx
RUN /bin/bash configure.sh
WORKDIR ..

CMD nginx && uwsgi --socket 0.0.0.0:$FLASK_PORT uwsgi/settings.ini
