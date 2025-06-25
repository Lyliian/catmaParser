## Compilation js/css
FROM node:lts as build-stage


WORKDIR /app


COPY ./app ./
RUN yarn global add @quasar/cli

RUN yarn

RUN yarn build


FROM caddy:2-builder AS builder
RUN xcaddy build --with github.com/caddyserver/encode-encoders

FROM caddy:2
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY --from=build-stage /app/dist/spa /srv
COPY ./deployments/Caddyfile /etc/caddy/Caddyfile