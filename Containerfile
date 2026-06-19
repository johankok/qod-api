FROM registry.access.redhat.com/ubi9/nodejs-22 AS builder

ENV APP_ROOT=/opt/app-root

WORKDIR $APP_ROOT

USER root
COPY src/ .
RUN npm ci --omit=dev

FROM registry.access.redhat.com/hi/nodejs:22

LABEL org.opencontainers.image.title="qod-api" \
      org.opencontainers.image.description="Quote of the Day REST API" \
      org.opencontainers.image.source="https://github.com/johankok/qod-api"

COPY --from=builder /opt/app-root/ /tmp/

EXPOSE 8080

CMD ["node", "/tmp/src/app.js"]
