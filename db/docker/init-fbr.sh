#!/bin/sh

set -e

POSTGRES="psql --username ${POSTGRES_USER}"

echo "Creating databases..."

$POSTGRES <<EOSQL
CREATE DATABASE fantasy-baseball-ranker-dev OWNER ${POSTGRES_USER};
EOSQL
