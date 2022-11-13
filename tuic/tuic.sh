#!/bin/sh

CONF="/etc/tuic/tuic.json"

# Download tuic binary

wget --no-check-certificate -O /etc/tuic-bin $TUIC_URL
chmod +x /etc/tuic-bin

# reuse existing config when the container restarts

run_bin() {
    /etc/tuic-bin --version
    /etc/tuic-bin -c ${CONF}
}
if [ -f ${CONF} ]; then
    echo "Found existing config..."
    run_bin
 else
    echo "Generating new config..."
    /etc/tuic-bin -c /etc/example.json
fi