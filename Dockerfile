## Compilation js/css
FROM node:lts as frontend

RUN yarn global add @quasar/cli

WORKDIR /app

COPY ./app/package*.json ./
RUN yarn

COPY ./app ./

RUN yarn build