# FlareSolverr v3.5.2 (MIT), unmodified, pinned for Thingport's importer. Listens on
# [::]:8191 so other services reach it over Railway's IPv6 private network.
FROM ghcr.io/flaresolverr/flaresolverr:v3.5.2
ENV HOST=:: LOG_LEVEL=info TZ=UTC
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/sh", "-c", "PORT=8191 exec /usr/local/bin/python -u /app/flaresolverr.py"]
CMD []
