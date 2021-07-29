FROM debian:10

RUN apt-get update && apt-get upgrade

RUN apt-get -y install python3 python3-pip

# Not required, but convenient for testing
RUN apt-get -y install curl

WORKDIR /app
COPY flask/requirements.txt ./requirements-flask.txt
RUN pip3 install -r requirements-flask.txt

COPY flask/main.py .

RUN apt-get -y install nginx

ARG FLASK_PORT=8000
ENV FLASK_PORT=$FLASK_PORT

# Just run a shell
# CMD ["/bin/bash"]


# Run Flask directly
# ENV FLASK_APP=flask/main.py
# CMD flask run --port $FLASK_PORT


# Run via uWSGI
COPY uwsgi/wsgi.py .
COPY uwsgi/requirements.txt ./requirements-uwsgi.txt
RUN pip3 install -r requirements-uwsgi.txt

COPY uwsgi/settings.ini .
# Run via uWSGI directly
# CMD uwsgi --protocol http --socket 0.0.0.0:$FLASK_PORT settings.ini


# Run via NGINX
COPY nginx/settings.conf .
COPY nginx/nginx.sh .
RUN /bin/bash nginx.sh

CMD nginx && uwsgi --socket 0.0.0.0:$FLASK_PORT settings.ini
