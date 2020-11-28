FROM node:12-alpine

ENV CHROMIUM_VERSION 81.0.4044.113
ENV PRERENDER_VERSION 5.8.0
ENV PRERENDER_MEMORY_VERSION 1.0.2
ENV DISPLAY :99.0

WORKDIR /app

RUN addgroup -S prerender && adduser -S -g prerender prerender  && \
    apk add --no-cache ca-certificates && \
    apk add chromium --no-cache && \
    npm install prerender@${PRERENDER_VERSION}  && \
    npm install prerender-memory-cache@${PRERENDER_MEMORY_VERSION} && \
    apk add wqy-zenhei --update-cache --repository http://nl.alpinelinux.org/alpine/edge/testing --allow-untrusted &&\
    rm -rf /var/cache/apk/*

COPY server.js /app/server.js

USER prerender

EXPOSE 3000

CMD [ "node", "server.js" ]
