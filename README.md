# Colorado Address Lookup

A simple web application that geocodes Colorado addresses and identifies which town or county they fall within using KML boundary files.

## Features

- Simple address input interface
- Geocodes addresses to latitude/longitude coordinates
- Checks if location falls within town boundaries (Towns.kml)
- Falls back to county boundaries (Counties.kml) if not in a town
- Displays the name of the matching town or county

## How to Run

### Option 1: As a Managed System Service (Recommended for Production)

Install as a systemd service that runs automatically on boot and restarts on failure:

```bash
sudo bash install-service.sh
```

The server will be accessible on your LAN. Check the server logs for the LAN IP address:

```bash
sudo journalctl -u colorado-address-lookup -f
```

**Service Management Commands:**
```bash
sudo systemctl status colorado-address-lookup   # Check status
sudo systemctl stop colorado-address-lookup     # Stop service
sudo systemctl start colorado-address-lookup    # Start service
sudo systemctl restart colorado-address-lookup  # Restart service
```

**To uninstall:**
```bash
sudo bash uninstall-service.sh
```

### Option 2: Using the provided script (LAN Access)

```bash
python3 server.py
```

The script will display both localhost and LAN URLs. Share the LAN URL with others on your network.

### Option 3: Python HTTP Server (Localhost Only)

```bash
python3 -m http.server 8000
```

Then open your browser to: http://localhost:8000

**Note:** This option only allows localhost access. For LAN access, use Option 1 or 2.

### Option 4: Any other local web server

You can use any local web server of your choice. Just make sure the `index.html`, `Towns.kml`, and `Counties.kml` files are in the same directory.

## Usage

1. Start the local web server (see above)
2. Open your browser to http://localhost:8000
3. Fill in the address fields:
   - House Number (e.g., 11367)
   - Street Name (e.g., Depew)
   - Street Type (select from dropdown: Way, Street, Avenue, etc.)
   - Zip Code (optional, e.g., 80020)
4. Click "Search" or press Enter
5. The app will display which town or county the address falls within

## Technical Details

- **Geocoding**: Uses Nominatim (OpenStreetMap) API for free geocoding
- **KML Parsing**: Uses toGeoJSON library to parse KML files
- **Point-in-Polygon**: Custom ray casting algorithm implementation
- **No backend required**: Entirely client-side JavaScript

## Files

- `index.html` - Main web application
- `Towns.kml` - Colorado town boundary data
- `Counties.kml` - Colorado county boundary data
- `server.py` - Python HTTP server with LAN access support
- `colorado-address-lookup.service` - Systemd service file
- `install-service.sh` - Service installation script
- `uninstall-service.sh` - Service uninstallation script
