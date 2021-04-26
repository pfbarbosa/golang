FROM golang:latest AS golang-builder

WORKDIR /go/src/app

RUN mkdir /go/src/app/hello
    
COPY hello.go/ /go/src/app/hello

RUN cd /go/src/app/hello && \
    go mod init example.com/hello && \
    go run . && \
    go build

RUN mkdir /go/src/app/target && \
    mv /go/src/app/hello/hello /go/src/app/target

FROM scratch
COPY --from=golang-builder /go/src/app/target/hello .
CMD ["/hello"]
