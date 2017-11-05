#!/bin/bash

# lazy template building. Substitue all variables starting with MOSQUITTO or HOSTNAME
IFS=$'\n'
for VAR in `env`; do
  KEY="${VAR%=*}"
  VAL="${VAR#*=}"
  if [[ $KEY =~ ^MOSQUITTO_ ]] || [[ $KEY =~ ^HOSTNAME ]]; then
    sed --in-place "s~$KEY~$VAL~" /mosquitto/config/mosquitto.conf
  fi
done

IFS=","
for broker in $MOSQUITTO_OTHER_BROKERS; do
	echo -e "\ntopic # in 2" '""' "$broker/" >> /mosquitto/config/mosquitto.conf
done


set -e
exec "$@"
