#!/bin/bash
# Uninstallation script for Colorado Address Lookup service

set -e

SERVICE_NAME="colorado-address-lookup"
SERVICE_FILE="$SERVICE_NAME.service"
SYSTEMD_DIR="/etc/systemd/system"

echo "===================================="
echo "Colorado Address Lookup Uninstaller"
echo "===================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo:"
    echo "  sudo bash uninstall-service.sh"
    exit 1
fi

# Stop service
echo "Stopping service..."
systemctl stop "$SERVICE_NAME" || true

# Disable service
echo "Disabling service..."
systemctl disable "$SERVICE_NAME" || true

# Remove service file
echo "Removing service file..."
rm -f "$SYSTEMD_DIR/$SERVICE_FILE"

# Reload systemd
echo "Reloading systemd daemon..."
systemctl daemon-reload

echo ""
echo "===================================="
echo "Uninstallation complete!"
echo "===================================="
echo ""
