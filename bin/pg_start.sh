#!/bin/bash

set +e

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

docker build -t fbr_postgres $SCRIPT_DIR/../db/docker
docker run --rm --name fbr_postgres \
    -e POSTGRES_PASSWORD=PASSWORD \
    -e POSTGRES_USER=rails_pg_user \
    -v fbr-pg-data:/var/lib/postgresql/data \
    -p 5432:5432 \
    -d fbr_postgres
