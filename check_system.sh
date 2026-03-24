#!/bin/bash
echo "SYSTEM HEALTH CHECK"

echo "1. Disk Usage:"
df -h | grep '/'
echo ""

# 2. Check Memory Usage
echo "2. Memory Usage:"
free -h
echo ""

echo "3. Nginx Status:"
sudo systemctl is-active nginx
echo ""

echo "4. Application Port (8080) Status:"
if ss -tuln | grep -q ":8080"; then
    echo "SUCCESS: Application is listening on port 8080."
else
    echo "FAILED: Port 8080 is NOT active. Ensure 'node server.js' is running."
fi