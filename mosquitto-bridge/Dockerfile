FROM eclipse-mosquitto:1.4.12

WORKDIR /mosquitto

#install base tools
RUN apk add --no-cache bash

COPY config/mosquitto.conf ./config