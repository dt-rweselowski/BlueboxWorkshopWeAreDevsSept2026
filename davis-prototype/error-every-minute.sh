#!/usr/bin/env bash
# Send one request per interval to an endpoint with a 100% injected 500, for OTel testing.
# Usage: davis-prototype/error-every-minute.sh [base-url] [interval-seconds]
# Needs the fault enabled first (the fault applies before routing, so the path need not exist):
#   davis-prototype/fault.sh '{"shop-api":{"GET /api/otel-test-error":1}}' 'otel test error on'
base="${1:-http://localhost:8088}"
interval="${2:-60}"
while true; do
  code="$(curl -s -o /dev/null -w '%{http_code}' "$base/api/otel-test-error")"
  printf '%s\tGET /api/otel-test-error\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$code"
  sleep "$interval"
done
