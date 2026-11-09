# Thingport on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/jj4eHq)

Thingport is a self-hosted library and importer for 3D-print models. This repo lets you deploy it on Railway with one click.

This repository packages the official [Thingport](https://github.com/TautvydasDerzinskas/Thingport) images (`thingport-backend` / `thingport-frontend` 1.5.0, AGPL-3.0) and FlareSolverr v3.5.2 (MIT) for Railway. It is independent community packaging and is not affiliated with the Thingport project.

## Services

| Service | Image | Notes |
| --- | --- | --- |
| frontend | `ghcr.io/onepush-dev/thingport-frontend:1.5.0-r2` | nginx serves the web UI on port 8080 and proxies `/api/*` to the backend over the private network. Health check: `/healthz`. Public domain. |
| backend | `ghcr.io/onepush-dev/thingport-backend:1.5.0-r2` | API on port 8000 (private). Volume at `/app/storage` for models, plates and thumbnails. |
| Postgres | `postgres:16-alpine` (pinned) | Volume at `/var/lib/postgresql/data`. |
| flaresolverr | `ghcr.io/onepush-dev/thingport-flaresolverr:3.5.2` | Helps imports from sites behind Cloudflare. Private network only. |

## First login

On its first boot the backend creates the owner account **admin@example.com**. Its password is in the backend variable `THINGPORT_ADMIN_PASSWORD`, which Railway generates for each deploy. After creating the owner, the backend **turns off public sign-up**, so a stranger cannot claim the instance. You can invite people from Administration. To leave sign-up open instead, set `THINGPORT_OPEN_REGISTRATIONS=true` before the first boot.

Change the owner email and password after you log in. To use AI features, add your provider key in Thingport's settings. The app runs without one.

## What this packaging changes

- backend: a start script bootstraps the owner once, using a marker file on the volume, then runs the upstream entrypoint unchanged.
- frontend: nginx listens on IPv4 and IPv6, resolves `backend.railway.internal` with Railway's DNS, and adds `/healthz`.
- flaresolverr: listens on `::` so other services can reach it over Railway's IPv6 private network.
