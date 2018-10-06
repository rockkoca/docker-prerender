FROM node:10.11.0-alpine

ENV CHROMIUM_VERSION 68.0.3440.106-r0
ENV PRERENDER_VERSION 5.4.4
ENV PRERENDER_MEMORY_VERSION 1.0.2
ENV DISPLAY :99.0

WORKDIR /app

RUN addgroup -S prerender && adduser -S -g prerender prerender  && \
    apk add --no-cache ca-certificates && \
    apk add chromium=${CHROMIUM_VERSION} --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community && \
    npm install prerender@${PRERENDER_VERSION}  && \
    npm install prerender-memory-cache@${PRERENDER_MEMORY_VERSION} && \
    rm -rf /var/cache/apk/*

COPY server.js /app/server.js

USER prerender

EXPOSE 3000

CMD [ "node", "server.js" ]
