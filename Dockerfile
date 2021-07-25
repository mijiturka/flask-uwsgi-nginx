FROM debian:10

RUN apt-get update && apt-get upgrade

RUN apt-get -y install python3 python3-pip

# Not required, but convenient for testing
RUN apt-get -y install curl

WORKDIR /app
COPY requirements.txt requirements-deployment.txt /app/
RUN pip3 install -r requirements-deployment.txt

COPY main.py /app

ARG FLASK_PORT=8000
ENV FLASK_PORT=$FLASK_PORT

# Just run a shell
# CMD ["/bin/bash"]

# Run Flask directly
# ENV FLASK_APP=main.py
# CMD flask run --port $FLASK_PORT

# Run via uWSGI
COPY wsgi.py /app
CMD uwsgi --socket 0.0.0.0:$FLASK_PORT --protocol=http -w wsgi:app
