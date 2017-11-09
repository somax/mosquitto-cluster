#!/bin/sh

# generate config file
CONFIG_FILE=/mosquitto/config/mosquitto.conf

cat << EOF > $CONFIG_FILE
# General Mosquitto Config
user mosquitto
allow_duplicate_messages false
autosave_interval 60
autosave_on_changes false
persistence true
persistence_file mosquitto.db
persistence_location /mosquitto/data/
log_dest stderr
log_type all
connection_messages true
log_timestamp true
listener 1883
EOF

if [ "$MOSQUITTO_BRIDGE_NODES" != "" ]; 
then

cat << EOF >> $CONFIG_FILE

# Bridge specific config
connection $HOSTNAME
round_robin false
try_private true
addresses $MOSQUITTO_BRIDGE_NODES
start_type automatic
notifications false
cleansession false
topic # out 2 "" $HOSTNAME/
EOF

IFS=","
for broker in $MOSQUITTO_OTHER_BROKERS; do
	echo "topic # in 2" '""' "$broker/" >> $CONFIG_FILE
done

fi

# from origin docker-entrypoint.sh
set -e
exec "$@"
