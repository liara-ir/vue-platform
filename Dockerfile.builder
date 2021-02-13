FROM node:12-alpine as build

WORKDIR /app

COPY default_liara_nginx.conf /app/liara_nginx.conf

RUN apk add git python3 build-base

ONBUILD COPY . /app

ONBUILD RUN if [ -e /app/package-lock.json ]; \
  then \
    echo 'Running npm ci...' && npm ci; \
  else \
    echo 'Running npm install' && npm install; \
fi

ONBUILD RUN npm run build
