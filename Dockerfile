FROM golang:alpine

RUN apk add --update ca-certificates git curl jq py-pip bash && pip install yq

RUN go get github.com/davidrjonas/semver-cli

ENTRYPOINT [ "semver-cli" ]