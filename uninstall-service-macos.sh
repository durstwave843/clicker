#!/bin/bash
# Uninstallation script for Colorado Address Lookup service on macOS

set -e

SERVICE_NAME="com.coloradoaddresslookup.server"
PLIST_FILE="$SERVICE_NAME.plist"
LAUNCH_DAEMON_DIR="/Library/LaunchDaemons"

echo "=========================================="
echo "Colorado Address Lookup Uninstaller (macOS)"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo:"
    echo "  sudo bash uninstall-service-macos.sh"
    exit 1
fi

# Unload service
echo "Stopping service..."
launchctl unload "$LAUNCH_DAEMON_DIR/$PLIST_FILE" 2>/dev/null || echo "Service was not loaded"

# Remove plist file
echo "Removing service file..."
rm -f "$LAUNCH_DAEMON_DIR/$PLIST_FILE"

# Optionally remove log files
echo ""
read -p "Remove log files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -f /tmp/colorado-address-lookup.log
    rm -f /tmp/colorado-address-lookup.error.log
    echo "Log files removed."
fi

echo ""
echo "=========================================="
echo "Uninstallation complete!"
echo "=========================================="
echo ""
