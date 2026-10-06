#!/bin/bash
# Generate self-signed TLS certificates for local dev
# Run this script once before docker compose up

set -e
CERT_DIR="$(dirname "$0")"

echo "Generating self-signed certificates..."

# app1.local
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/app1.key" \
  -out "$CERT_DIR/app1.crt" \
  -subj "/CN=app1.local/O=DevOps Lab/C=IN" \
  -addext "subjectAltName=DNS:app1.local,DNS:localhost"

# app2.local  
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/app2.key" \
  -out "$CERT_DIR/app2.crt" \
  -subj "/CN=app2.local/O=DevOps Lab/C=IN" \
  -addext "subjectAltName=DNS:app2.local,DNS:localhost"

echo "Certificates generated:"
ls -la "$CERT_DIR"/*.crt "$CERT_DIR"/*.key
