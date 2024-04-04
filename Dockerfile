FROM --platform=linux quay.io/projectquay/golang:1.22 as builder
ARG os=linux
ENV TARGETOS=${os}

WORKDIR /go/src/app
COPY . .
RUN make $TARGETOS


FROM golang:1.22 as linux
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT [ "./kbot" ]

FROM --platform=arm64 golang:1.22 as linux_arm
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT [ "./kbot" ]

FROM --platform=windows golang:1.22 as windows
WORKDIR /
COPY --from=builder /go/src/app/kbot ./kbot.exe
ENTRYPOINT [ "kbot.exe" ]