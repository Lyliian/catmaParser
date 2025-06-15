## Compilation js/css
FROM node:lts as build-stage


WORKDIR /app


COPY ./app ./
RUN yarn global add @quasar/cli

RUN yarn

RUN yarn build

# Production stage
FROM nginx:alpine as production-stage
