## Compilation js/css
FROM node:lts as frontend

WORKDIR /app

COPY ./app/package*.json ./
RUN yarn

COPY ./app ./

RUN yarn build