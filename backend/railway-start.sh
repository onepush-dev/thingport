#!/bin/sh
# Thingport makes the FIRST account to register the instance owner/admin.
# This creates that owner from per-deploy credentials on a side port before
# the backend starts serving on its real port (8000, the one the frontend
# proxies to), so no visitor can claim the instance first.
set -eu
MARKER=/app/storage/.railway-owner-created
mkdir -p /app/storage
if [ ! -f "$MARKER" ] && [ -n "${THINGPORT_ADMIN_PASSWORD:-}" ]; then
  echo "[railway] creating the owner account before opening port ${API_PORT:-8000}"
  API_PORT=8001 docker-entrypoint.sh node dist/server.js &
  pid=$!
  i=0
  until wget -q -O /dev/null http://127.0.0.1:8001/api/health; do
    i=$((i+1)); [ $i -gt 180 ] && { echo "[railway] backend did not come up" >&2; kill $pid; exit 1; }
    sleep 1
  done
  body=$(printf '{"displayName":"%s","email":"%s","password":"%s"}' "${THINGPORT_ADMIN_NAME:-Admin}" "${THINGPORT_ADMIN_EMAIL:-admin@example.com}" "$THINGPORT_ADMIN_PASSWORD")
  if out=$(wget -q -O - --header 'Content-Type: application/json' --post-data "$body" http://127.0.0.1:8001/api/register 2>&1); then
    touch "$MARKER"; echo "[railway] owner account created (${THINGPORT_ADMIN_EMAIL:-admin@example.com})"
  else
    echo "[railway] owner registration failed: $out" >&2
  fi
  kill $pid 2>/dev/null || true
  wait $pid 2>/dev/null || true
  [ -f "$MARKER" ] || { echo "[railway] refusing to serve until an owner exists" >&2; exit 1; }
fi
exec docker-entrypoint.sh node dist/server.js
