#!/bin/bash
# Installation script for Colorado Address Lookup service on macOS

set -e

SERVICE_NAME="com.coloradoaddresslookup.server"
PLIST_FILE="$SERVICE_NAME.plist"
LAUNCH_DAEMON_DIR="/Library/LaunchDaemons"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMP_PLIST="/tmp/$PLIST_FILE"

echo "========================================"
echo "Colorado Address Lookup Installer (macOS)"
echo "========================================"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo:"
    echo "  sudo bash install-service-macos.sh"
    exit 1
fi

# Get the actual user (not root, since we're running with sudo)
ACTUAL_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo ~$ACTUAL_USER)

echo "Installing for user: $ACTUAL_USER"
echo "Home directory: $USER_HOME"
echo "Script directory: $SCRIPT_DIR"
echo ""

# Create temporary plist with correct paths
echo "Creating service configuration..."
sed "s|/Users/USER|$USER_HOME|g" "$SCRIPT_DIR/$PLIST_FILE" > "$TEMP_PLIST"

# If script is not in ~/clicker, update the path
if [[ "$SCRIPT_DIR" != "$USER_HOME/clicker" ]]; then
    sed -i '' "s|$USER_HOME/clicker|$SCRIPT_DIR|g" "$TEMP_PLIST"
fi

# Copy plist file
echo "Installing service file..."
cp "$TEMP_PLIST" "$LAUNCH_DAEMON_DIR/$PLIST_FILE"
chown root:wheel "$LAUNCH_DAEMON_DIR/$PLIST_FILE"
chmod 644 "$LAUNCH_DAEMON_DIR/$PLIST_FILE"

# Load the service
echo "Loading service..."
launchctl load "$LAUNCH_DAEMON_DIR/$PLIST_FILE"

# Clean up
rm -f "$TEMP_PLIST"

echo ""
echo "========================================"
echo "Installation complete!"
echo "========================================"
echo ""
echo "The service is now running and will start automatically on boot."
echo ""
echo "View logs:"
echo "  tail -f /tmp/colorado-address-lookup.log"
echo "  tail -f /tmp/colorado-address-lookup.error.log"
echo ""
echo "Useful commands:"
echo "  sudo launchctl list | grep colorado     # Check if running"
echo "  sudo launchctl unload $LAUNCH_DAEMON_DIR/$PLIST_FILE   # Stop service"
echo "  sudo launchctl load $LAUNCH_DAEMON_DIR/$PLIST_FILE     # Start service"
echo ""
echo "To uninstall:"
echo "  sudo bash uninstall-service-macos.sh"
echo ""
