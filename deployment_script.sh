#!/bin/bash

set -e #Exit if any command fails

log() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a /tmp/deploy.log
}

log "Starting deployment..."

#Check if required command exist

if ! command -v docker &> /dev/null; then 
	log "Error: Docker not installed"
	exit 1
fi

if ! command -v git &> /dev/null; then
	log "Error: Git not installed"
	exit 1
fi 

log "All dependencies found"

#Simulate deployment steps

log "Cloning Repository"
sleep 1

log "Building Application..."
sleep 1

log "Deployment complete!"
log "Exit code: $?"
