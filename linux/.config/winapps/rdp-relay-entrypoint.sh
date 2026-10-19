#!/bin/sh
# Ensure socat is installed (if not, install it)
if ! command -v socat >/dev/null 2>&1; then
	echo "Installing socat..."
	apt-get update && apt-get install -y socat || apk add --no-cache socat
fi

# Start RDP relay in background
socat TCP-LISTEN:3389,fork,reuseaddr TCP:172.30.1.2:3389 &

# Run the original entrypoint
exec /usr/bin/tini -s /run/entry.sh "$@"
