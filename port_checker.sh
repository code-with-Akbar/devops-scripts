#!/bin/bash

check_port() {
	local PORT=$1
	echo "Checking ports $PORT..."

	if ss -lnt | grep ":$PORT" > /dev/null; then 
	echo "Port $PORT is Open"
	else
	echo "Port $PORT is Closed"
	fi

}

echo "=== Ports Status Check ==="

check_port 5432
check_port 20
check_port 80
check_port 631

