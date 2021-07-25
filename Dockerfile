FROM debian:10

RUN apt-get update && apt-get upgrade

RUN apt-get -y install python3 python3-pip

WORKDIR /app
COPY requirements.txt requirements-deployment.txt /app/
RUN pip3 install -r requirements-deployment.txt

COPY main.py /app

ENV FLASK_APP=main.py

CMD ["/bin/bash flask run"]
