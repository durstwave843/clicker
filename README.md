# Colorado Address Lookup

A simple web application that geocodes Colorado addresses and identifies which town or county they fall within using KML boundary files.

## Features

- Simple address input interface
- Geocodes addresses to latitude/longitude coordinates
- Checks if location falls within town boundaries (Towns.kml)
- Falls back to county boundaries (Counties.kml) if not in a town
- Displays the name of the matching town or county

## How to Run

### Option 1: Python HTTP Server (Recommended)

```bash
python3 -m http.server 8000
```

Then open your browser to: http://localhost:8000

### Option 2: Using the provided script

```bash
python3 server.py
```

Then open your browser to: http://localhost:8000

### Option 3: Any other local web server

You can use any local web server of your choice. Just make sure the `index.html`, `Towns.kml`, and `Counties.kml` files are in the same directory.

## Usage

1. Start the local web server (see above)
2. Open your browser to http://localhost:8000
3. Enter a Colorado address in the input field (e.g., "1600 Broadway, Denver, CO")
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
- `server.py` - Simple Python HTTP server script
