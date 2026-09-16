#!/bin/bash

#Create a log file 
create_log() {
	local LOG_FILE=$1
	echo "Creating log file: $LOG_FILE"
	touch "$LOG_FILE"
	echo "[$(date)] Log file created" >> "$LOG_FILE"
}

#Append to log
log_message() {
	local LOG_FILE=$1
	local MESSAGE=$2
	echo "[$(date)] $MESSAGE" >> "$LOG_FILE"
}

#Read log
read_log() {
	local LOG_FILE=$1
	echo "=== Log contents ==="
	cat "$LOG_FILE"
}

#Main Script
LOG_FILE="/tmp/my_app.log"

create_log "$LOG_FILE" "Application started"
log_message "$LOG_FILE" "Database Connected"
log_message "$LOG_FILE" "Service healthy"

read_log "$LOG_FILE"
