#!/bin/bash
# Cleanup script for temporary files, swap, and leftover CyberPanel artifacts
# Usage: sudo ./cleanup.sh

# Remove CyberPanel swap
SWAP_FILE="/var/lib/cyberpanel.swap"
if [ -f "$SWAP_FILE" ]; then
    echo "Removing CyberPanel swap..."
    sudo swapoff "$SWAP_FILE"
    sudo rm -f "$SWAP_FILE"
fi

# Stop Docker services if running
echo "Stopping Docker services..."
sudo systemctl stop docker
sudo systemctl disable docker
sudo systemctl stop docker.socket
sudo systemctl disable docker.socket

echo "Cleanup completed."

