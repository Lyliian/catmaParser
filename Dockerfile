## Compilation js/css
FROM node:lts as frontend


WORKDIR /app

RUN yarn global add @quasar/cli

COPY ./app/package*.json ./
RUN yarn

COPY ./app ./

RUN yarn build