# Twilio certbot auto updater

Twilio's link shortening feature requires that RSA TSL certificate and private keys are uploaded to it.
Twilio does not natively support auto-provisioning and autorenewal of certificates with direct integration with Letsencrypt or
other similar providers.

This docker image automates the process.

* Uses DNS-01 authentication to download certificate from letsencrypt.
* Uses certbot to interact with letsencrypt.
* Uses certbot's cloudflare plugin for auto authentication.
* Calls Twilio API to update new certificates.
* Runs every 12 hours.
* Uses supercronic, a container friendly cron.
* All credentials are passed in via environment variables.

## Environment Variables

Please set **all** of the following environment variables:

* **CLOUDFLARE_API_TOKEN** (Cloudflare > Profile > API Tokens > Create Token). Create a new token with DNS EDIT permission.
* **DOMAIN** The domain you want to update
* **EMAIL** The email that will be sent to Letsencrypt
* **DOMAIN_SID** Get this from https://www.twilio.com/console/admin/domains. Starts with `DN`. Eg: `DNXXXX`
* **TWILIO_ACCOUNT_SID** Get this from Twilio
* **TWILIO_AUTH_TOKEN** Get this from Twilio



