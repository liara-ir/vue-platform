FROM node:14 as build

WORKDIR /app

RUN apt-get update;apt-get install git python3 build-essential

COPY default_liara_nginx.conf /app/liara_nginx.conf

COPY lib/* /usr/local/lib/liara/

ONBUILD ARG __NODE_MIRROR=false
ONBUILD ARG __NODE_MIRRORURL
ONBUILD ARG __NODE_GITHUBMIRRORURL

ONBUILD ENV __NODE_MIRROR=${__NODE_MIRROR}
ONBUILD ENV __NODE_MIRRORURL=${__NODE_MIRRORURL}
ONBUILD ENV __NODE_GITHUBMIRRORURL=${__NODE_GITHUBMIRRORURL}

ONBUILD COPY . /app

ONBUILD RUN /usr/local/lib/liara/configure.sh

ONBUILD RUN npm run build
