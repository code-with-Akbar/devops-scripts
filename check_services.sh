#!/bin/bash

echo "=== Service Status Check ==="

SERVICES=("postgresql" "ssh" "docker")

for service in ${SERVICES[@]}; do
  if systemctl is-active --quiet $service; then 
	echo "$service is running"
  else
	echo "$service is not running"
fi

done
