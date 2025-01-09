#!/bin/bash

# Echo the entered SPAN_PORT value
echo "Entered SPAN_PORT value: $SPAN_PORT"

# Create necessary directories
mkdir -p /root/docker/span-promisc
# Create the docker-compose.yml file
cat <<EOF > /root/docker/span-promisc/docker-compose.yml
version: '3.8'

services:
  span-interface:
    image: alpine:latest
    container_name: Span-Interface
    command: >
      /bin/sh -c "
      ip link set $SPAN_PORT  up &&
      ip link set $SPAN_PORT  promisc on &&
      tail -f /dev/null
      "
    network_mode: "host"
    cap_add:
      - NET_ADMIN
    restart: unless-stopped

EOF

echo "Docker Compose file created at /root/docker/span-promisc/docker-compose.yml"
