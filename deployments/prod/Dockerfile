ARG NODE_IMAGE

## Compilation js/css
FROM ${NODE_IMAGE} as frontend

WORKDIR /app

COPY ./app/package*.json ./
RUN yarn

COPY ./app/ ./

RUN yarn build