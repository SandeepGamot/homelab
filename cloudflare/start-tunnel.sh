#!/bin/bash

source ./.env

NETWORK_NAME="$DEFAULT_NETWORK_NAME"

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -n|--network)
            NETWORK_NAME="$2"
            shift 2
            ;;
        *)
            echo "Usage: $0 [-n|--network <network_name>]"
            exit 1
            ;;
    esac
done

echo "Starting tunnel on the $NETWORK_NAME network..."

if ! docker network ls | grep -q "$NETWORK_NAME"; then
  echo "Error: Network $NETWORK_NAME not found. Please create first."
  exit 1
fi

export NETWORK_NAME

docker compose up --build --force-recreate