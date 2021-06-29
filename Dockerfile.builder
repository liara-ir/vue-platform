FROM node:12-alpine as build

WORKDIR /app

COPY default_liara_nginx.conf /app/liara_nginx.conf

RUN apk add git bash python3 build-base

COPY lib/* /usr/local/lib/liara/

ONBUILD ARG __NODE_MIRROR=false
ONBUILD ARG __NODE_MIRRORURL
ONBUILD ARG __NODE_GITHUBMIRRORURL

ONBUILD ENV __NODE_MIRROR=${__NODE_MIRROR}
ONBUILD ENV __NODE_MIRRORURL=${__NODE_MIRRORURL}
ONBUILD ENV __NODE_GITHUBMIRRORURL=${__NODE_GITHUBMIRRORURL}

ONBUILD RUN /usr/local/lib/liara/configure.sh

ONBUILD COPY . /app

ONBUILD RUN if [ -e /app/package-lock.json ]; \
  then \
    echo 'Running npm ci...' && npm ci; \
  else \
    echo 'Running npm install' && npm install; \
fi

ONBUILD RUN npm run build
