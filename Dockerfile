FROM golang:1.17.2 AS builder

ADD . /app
WORKDIR /app
RUN GOPROXY=https://goproxy.cn GOSUMDB=off GO11MODULE=on go mod vendor
RUN CGO_ENABLED=0 GOOS=linux GO11MODULE=on go build -mod=vendor -a -o /main .

FROM alpine:3.11.6
RUN addgroup -g 1000 nonroot && \
    adduser -u 1000 -D -H -G nonroot nonroot
COPY --from=builder --chown=nonroot:nonroot /main /kubernetes-event-exporter

USER nonroot:nonroot
RUN ls -l /kubernetes-event-exporter

ENTRYPOINT ["/kubernetes-event-exporter"]
