#!/bin/sh
set -eu

: "${KEYCLOAK_SMTP_PASSWORD:?KEYCLOAK_SMTP_PASSWORD is required}"

TEMPLATE_FILE="/opt/keycloak/data/import/realm-template.json"
GENERATED_FILE="/tmp/realm.json"

escaped_password=$(printf '%s' "$KEYCLOAK_SMTP_PASSWORD" | sed -e 's/[\\/&]/\\\\&/g')
sed "s/__SMTP_PASSWORD__/${escaped_password}/g" "$TEMPLATE_FILE" > "$GENERATED_FILE"

/opt/keycloak/bin/kc.sh import --file "$GENERATED_FILE" --override=false

exec /opt/keycloak/bin/kc.sh start --hostname-strict=false --optimized --http-enabled=true