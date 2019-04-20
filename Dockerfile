FROM golang:alpine as go

RUN apk add --update ca-certificates git curl jq py-pip bash && pip install yq

RUN go get github.com/davidrjonas/semver-cli

RUN which jq

FROM alpine:3.8

RUN apk add --update ca-certificates git curl jq py-pip bash && pip install yq

COPY --from=go /go/bin/semver-cli /usr/local/bin/semver-cli

ENTRYPOINT [ "semver-cli" ]