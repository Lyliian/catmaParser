## Compilation js/css
FROM node:lts as build-stage


WORKDIR /app


COPY ./app ./
RUN yarn global add @quasar/cli

RUN yarn

RUN yarn build

RUN ls -la /app/dist/spa

# Production stage
FROM nginx:alpine as production-stage
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
