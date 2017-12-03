#!/bin/sh

# generate config file
CONFIG_FILE=/mosquitto/config/mosquitto.conf
IFS=","

cat << EOF > $CONFIG_FILE
# General Mosquitto Config
user mosquitto
allow_duplicate_messages false
autosave_interval 60
autosave_on_changes false
persistence true
persistence_file mosquitto.db
persistence_location /mosquitto/data/
connection_messages true
log_timestamp true
listener 1883
EOF


for logType in $MOSQUITTO_LOG_TYPE; do
	echo "log_type $logType" >> $CONFIG_FILE
done

if [ "$MOSQUITTO_LOG_DEST" != "" ]; then

for logDest in $MOSQUITTO_LOG_DEST; do
	echo "log_dest $logDest" >> $CONFIG_FILE
done

fi

if [ "$MOSQUITTO_BRIDGE_NODES" != "" ]; then

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

for broker in $MOSQUITTO_OTHER_BROKERS; do
	echo "topic # in 2" '""' "$broker/" >> $CONFIG_FILE
done

fi

# from origin docker-entrypoint.sh
set -e
exec "$@"
