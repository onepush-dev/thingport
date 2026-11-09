# Thingport frontend on Railway: official image (1.5.0, AGPL-3.0), app unmodified.
# Only nginx.conf changes: listen on 8080 (dual-stack) and reach the backend over
# Railway's private network (backend.railway.internal:8000) instead of compose DNS.
FROM ghcr.io/tautvydasderzinskas/thingport-frontend:1.5.0@sha256:1dc0db5e494b946ea9cd3d36bd91c196f96d57e2144e392a707e6613c4ff4f73
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
