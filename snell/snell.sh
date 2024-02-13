#!/bin/sh

BIN="/usr/bin/snell-server"
CONF="/etc/snell-server.conf"

# Download snell binary

download_bin() {
wget --no-check-certificate -O snell.zip $SNELL_URL
unzip snell.zip
rm -f snell.zip
chmod +x snell-server
mv snell-server /usr/bin/
}

# reuse existing config when the container restarts

run_bin() {
    ${BIN} --version
    ${BIN} -c ${CONF}
}
if [ -f ${BIN} ]; then
    echo "Found existing binary..."
    run_bin
fi

if [ -f ${CONF} ]; then
    echo "Found existing config..."
    download_bin
    run_bin
 else
    if [ -z ${PSK} ]; then
        PSK=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
        echo "Using generated PSK: ${PSK}"
    else
        echo "Using predefined PSK: ${PSK}"
    fi
    echo "Generating new config..."
    echo "[Snell Server]" >> ${CONF}
    echo "interface = 0.0.0.0" >> ${CONF}
    echo "port = 6160" >> ${CONF}
    echo "psk = 3iR6KAPRyt3VT06" >> ${CONF}
    run_bin
fi
