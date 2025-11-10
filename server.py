#!/usr/bin/env python3
"""
Simple HTTP server for the Colorado Address Lookup webapp.
Run this script to start a local web server on port 8000.
"""

import http.server
import socketserver
import socket
import os

PORT = 8000

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Add CORS headers to allow local development
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

def get_lan_ip():
    """Get the LAN IP address of this machine."""
    try:
        # Create a socket to find the local IP
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        return None

def main():
    # Change to the directory where this script is located
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    # Bind to 0.0.0.0 to accept connections from all network interfaces
    with socketserver.TCPServer(("0.0.0.0", PORT), MyHTTPRequestHandler) as httpd:
        lan_ip = get_lan_ip()

        print("=" * 60)
        print("Colorado Address Lookup - Server Started")
        print("=" * 60)
        print(f"\nLocal access:")
        print(f"  http://localhost:{PORT}/")

        if lan_ip:
            print(f"\nLAN access (share this with others on your network):")
            print(f"  http://{lan_ip}:{PORT}/")

        print("\nPress Ctrl+C to stop the server")
        print("=" * 60)

        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nServer stopped.")

if __name__ == "__main__":
    main()
