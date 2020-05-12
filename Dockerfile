FROM golang:alpine as go

RUN apk add --update ca-certificates git curl jq py-pip bash && pip install yq

RUN go get github.com/davidrjonas/semver-cli

FROM alpine:3.11

RUN apk add --update ca-certificates git curl jq py-pip bash && pip install yq

COPY --from=go /go/bin/semver-cli /usr/local/bin/semver-cli

RUN curl -L https://github.com/github/hub/releases/download/v2.14.2/hub-linux-386-2.14.2.tgz --output hub.tgz && tar -xzf hub.tgz && mv hub-linux-386-2.14.2/bin/hub /usr/local/bin && rm hub.tgz && rm -rf hub-linux-386-2.14.2

ENTRYPOINT [ "semver-cli" ]