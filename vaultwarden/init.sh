#!/usr/bin/sh
echo "Set Admin Token" 
export ADMIN_TOKEN=$(cat /run/secrets/vaultwarden_admin_token)

echo "Set SMTP Password"
export SMTP_PASSWORD=$(cat /run/secrets/google_smtp_pass)