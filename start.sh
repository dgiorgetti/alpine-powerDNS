#!/usr/bin/env ash

SQL_INIT_SCRIPT=/pdns/init-sqlite.sql

echo "Starting PowerDNS"
sleep 1

# Import schema structure
if [ -f ${SQL_INIT_SCRIPT} ]; then
	echo "Initilizing Database..."
	sqlite3 /pdns/powerdns.sqlite < ${SQL_INIT_SCRIPT}
	rm ${SQL_INIT_SCRIPT}
	echo "Done"
else
	echo "Database Already Initilized!"
fi

pdns_server \
	--webserver=yes \
	--webserver-address=0.0.0.0 \
	--webserver-port=${PDNS_WEBSERVER_PORT:-8080} \
	--api=yes \
	--daemon=no \
	--loglevel=9 \
	--disable-tcp=no \
	--api-key=${PDNS_API_KEY} \
	--recursor=${PDNS_RECURSOR} \
	--launch=gsqlite3 \
	--gsqlite3-database=/pdns/powerdns.sqlite
