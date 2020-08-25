FROM node:14-alpine
WORKDIR /usr/src/app
ARG NODE_ENV=production

RUN apk --no-cache add \
    pango-dev \
    giflib-dev

RUN apk update && apk upgrade && \
    apk --no-cache --virtual build-dependencies add \
    bash \
    g++ \
    make \
    python && \
    rm -rf /var/cache/apk/*

RUN echo @edge http://nl.alpinelinux.org/alpine/v3.8/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/v3.8/main >> /etc/apk/repositories && \
    apk add --no-cache \
    chromium \
    nss \
    freetype@edge \
    harfbuzz@edge \
    ttf-freefont@edge && \
    rm -rf /var/cache/apk/* && \
    rm -f /var/log/apache/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
ENV CHROMIUM_PATH=/usr/bin/chromium-browser

# Memory limit
ENV NODE_OPTIONS="--max-old-space-size=4096"
