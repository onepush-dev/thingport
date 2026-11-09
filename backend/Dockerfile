# Thingport backend on Railway: official image (TautvydasDerzinskas/Thingport 1.5.0, AGPL-3.0),
# unmodified, plus a start script that registers the owner account from per-deploy
# credentials before the API serves on :8000 (upstream: the first sign-up becomes owner).
FROM ghcr.io/tautvydasderzinskas/thingport-backend:1.5.0@sha256:d0191b911d1fa451a0c26b5df5543c4b9c77e1a6b63e888bc8583f360b6b79f1
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod 755 /usr/local/bin/railway-start.sh
ENV API_PORT=8000 \
    FILE_STORAGE=/app/storage \
    PUID=1000 PGID=1000 CHOWN_MODE=recursive \
    AUTH_TOKEN_TTL=43200 \
    FLARESOLVERR_URL=http://flaresolverr.railway.internal:8191/v1 \
    FLARESOLVERR_REQUIRE_HTTPS=false \
    THINGPORT_ADMIN_NAME=Admin \
    THINGPORT_ADMIN_EMAIL=admin@example.com \
    TZ=UTC
ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
CMD []
