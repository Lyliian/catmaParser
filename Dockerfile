## Compilation js/css
FROM node:lts as build-stage


WORKDIR /app


COPY ./app ./
RUN yarn global add @quasar/cli

RUN yarn

RUN yarn build


FROM caddy:2
COPY ./deployments/Caddyfile /etc/caddy/Caddyfile
COPY --from=build-stage /app/dist/spa /srv
COPY ./deployments/entrypoint.sh /usr/bin/entrypoint.sh

# Entrypoint personnalisé
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
