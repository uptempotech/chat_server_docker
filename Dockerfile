FROM golang:alpine as build-env

ENV GO111MODULE=on

RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir -p /uptempo.tech/docker_example
RUN mkdir -p /uptempo.tech/docker_example/proto

WORKDIR /uptempo.tech/docker_example

COPY ./proto/service.pb.go /uptempo.tech/docker_example/proto
COPY ./main.go /uptempo.tech/docker_example

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o docker_example .

CMD ./docker_example