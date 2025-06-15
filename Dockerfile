## Compilation js/css
FROM node:lts as frontend


WORKDIR /app


COPY ./app ./
RUN yarn global add @quasar/cli

RUN yarn

RUN yarn build