FROM alpine:3.12 AS builder
RUN apk update && apk add gcc make nettle-dev linux-headers libc-dev
ADD . /dnsmasq-build
RUN make -C /dnsmasq-build all

FROM alpine:3.12
COPY --from=builder /dnsmasq-build/src/dnsmasq /usr/bin

EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "-k"]
