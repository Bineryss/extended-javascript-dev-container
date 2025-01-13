#!/bin/bash

DOCKER_SOCKET=/var/run/docker.sock

echo "Adjusting permissions for Docker socket..."
if [ -S $DOCKER_SOCKET ]; then
  DOCKER_GID=$(stat -c "%g" $DOCKER_SOCKET)
  echo "Docker socket found with GID: $DOCKER_GID"

  # Check if a group with this GID already exists
  EXISTING_GROUP=$(getent group $DOCKER_GID | cut -d: -f1)
  if [ -z "$EXISTING_GROUP" ]; then
    echo "Creating group 'docker-host' with GID $DOCKER_GID"
    groupadd -g $DOCKER_GID docker-host
  else
    echo "Using existing group '$EXISTING_GROUP'"
  fi

  # Add 'node' user to this group
  echo "Adding 'node' user to group '${EXISTING_GROUP:-docker-host}'"
  usermod -aG ${EXISTING_GROUP:-docker-host} node

else
  echo "Warning: Docker socket ($DOCKER_SOCKET) not found or not a valid socket. Docker CLI may not work."
fi

# Execute original entrypoint or passed command(s)
exec "$@"
