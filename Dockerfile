FROM golang:1.14-alpine AS builder

RUN apk add --no-cache curl make

WORKDIR /build

RUN apk add --no-cache git

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN ./build.sh

FROM alpine:3.12

WORKDIR app

COPY --from=builder /build/bin/binance_linux_amd64 /usr/local/bin/binance

CMD ["binance"]