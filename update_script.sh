# ENV VARIABLES:
# * CLOUDFLARE_API_TOKEN
# * DOMAIN
# * EMAIL
# * DOMAIN_SID
# * TWILIO_ACCOUNT_SID
# * TWILIO_AUTH_TOKEN

set -e

echo "dns_cloudflare_api_token = $CLOUDFLARE_API_TOKEN" > /app/config/cloudflare.ini

# Downloads letsencrypt keys to /etc/letsencrypt/live/$DOMAIN
certbot certonly \
    -d $DOMAIN \
    -n \
    --dns-cloudflare \
    --agree-tos \
    --email $EMAIL \
    --dns-cloudflare-credentials=/app/config//cloudflare.ini \
    --dns-cloudflare-propagation-seconds 15 \
    --key-type rsa

CERT_AND_PRIVATE_KEY="$(cat /etc/letsencrypt/live/$DOMAIN/cert.pem; cat /etc/letsencrypt/live/$DOMAIN/privkey.pem)"

curl -X POST "https://messaging.twilio.com/v1/LinkShortening/Domains/$DOMAIN_SID/Certificate" \
  --data-urlencode "TlsCert=$CERT_AND_PRIVATE_KEY" \
  -u $TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN

