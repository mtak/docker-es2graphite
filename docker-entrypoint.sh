#!/bin/bash
set -e

if [[ "x$GRAPHITE_HOST" = "x" ]]; then
  export GRAPHITE_HOST="localhost"
fi

if [[ "x$GRAPHITE_PORT" = "x" ]]; then
  export GRAPHITE_PORT="2003"
fi

if [[ "x$ES_HOST" = "x" ]]; then
  export ES_HOST="localhost"
fi

if [[ "x$ES_PORT" = "x" ]]; then
  export ES_PORT="9200"
fi

if [[ "x$PROTOCOL" = "x" ]]; then
  export PROTOCOL="plaintext"
fi

if [[ "x$LOGLEVEL" = "x" ]]; then
  export LOGLEVEL="error"
fi

if [[ "x$HEALTHLEVEL" = "x" ]]; then
  export HEALTHLEVEL="cluster"
fi

if [[ "x$INTERVAL" = "x" ]]; then
  export INTERVAL="60"
fi

export ES_ADDR="${ES_HOST}:${ES_PORT}"

exec /es2graphite.py -g "$GRAPHITE_HOST" -o "$GRAPHITE_PORT" --health-level "$HEALTHLEVEL" --protocol "$PROTOCOL" --log-level "$LOGLEVEL" --stdout "$ES_ADDR"
