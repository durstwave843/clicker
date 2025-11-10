#!/bin/bash
# Installation script for Colorado Address Lookup service

set -e

SERVICE_NAME="colorado-address-lookup"
SERVICE_FILE="$SERVICE_NAME.service"
SYSTEMD_DIR="/etc/systemd/system"

echo "=================================="
echo "Colorado Address Lookup Installer"
echo "=================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo:"
    echo "  sudo bash install-service.sh"
    exit 1
fi

# Copy service file
echo "Installing service file..."
cp "$SERVICE_FILE" "$SYSTEMD_DIR/$SERVICE_FILE"

# Reload systemd
echo "Reloading systemd daemon..."
systemctl daemon-reload

# Enable service
echo "Enabling service to start on boot..."
systemctl enable "$SERVICE_NAME"

# Start service
echo "Starting service..."
systemctl start "$SERVICE_NAME"

# Check status
echo ""
echo "=================================="
echo "Installation complete!"
echo "=================================="
echo ""
echo "Service status:"
systemctl status "$SERVICE_NAME" --no-pager
echo ""
echo "Useful commands:"
echo "  sudo systemctl status $SERVICE_NAME   # Check status"
echo "  sudo systemctl stop $SERVICE_NAME     # Stop service"
echo "  sudo systemctl start $SERVICE_NAME    # Start service"
echo "  sudo systemctl restart $SERVICE_NAME  # Restart service"
echo "  sudo journalctl -u $SERVICE_NAME -f   # View live logs"
echo ""
