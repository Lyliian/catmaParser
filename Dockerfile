## Compilation js/css
FROM node:lts as build-stage


WORKDIR /app


COPY ./app ./
RUN yarn global add @quasar/cli

RUN yarn

RUN yarn build

# Production stage
#FROM --platform=linux/amd64 nginx:alpine as production-stage-amd64
#COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]


FROM --platform=linux/arm64 arm64v8/nginx as production-stage-arm64
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
EXPOSE 80
CMD ["nginx-debug", "-g", "daemon off;"]

# Étape finale qui sélectionne automatiquement la bonne image
FROM production-stage-$TARGETARCH as production-stage