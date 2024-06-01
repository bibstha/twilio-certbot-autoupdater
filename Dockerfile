FROM certbot/dns-cloudflare:latest
LABEL authors="bibekshrestha@gmail.com"

ENTRYPOINT []
WORKDIR /app

RUN apk add --no-cache supercronic
COPY crontab .

COPY update_script.sh .
RUN chmod +x update_script.sh

RUN mkdir -p /app/config

CMD supercronic /app/crontab
