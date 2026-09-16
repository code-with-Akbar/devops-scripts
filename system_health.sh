#!/bin/bash

echo "=== System Health Check ==="

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
TOTAL_RAM=$(free -h | grep "^Mem" | awk '{print $2}')
FREE_RAM=$(free -h | grep "^Mem" | awk '{print $7}')
CPU_CORES=$(nproc)
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}')

echo "Hostname: $HOSTNAME"
echo "Current User: $CURRENT_USER"
echo "Total Ram: $TOTAL_RAM"
echo "Free Ram: $FREE_RAM"
echo "Cpu Cores: $CPU_CORES"
echo "Disk Usage: $DISK_USAGE"

#Alert if disk usage >80%
DISK_PERCENT=${DISK_USAGE%\%}

if [ $DISK_PERCENT -gt 80 ]; then 
  echo "WARNING: Disk Usage is Critical!"
else
  echo "Disk Usage is normal"
fi
