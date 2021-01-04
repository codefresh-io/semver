FROM golang:alpine as go

RUN apk add --update git

RUN go get github.com/davidrjonas/semver-cli

FROM alpine:3.11

RUN apk add --update ca-certificates git curl jq py-pip bash && pip install yq

COPY --from=go /go/bin/semver-cli /usr/local/bin/semver-cli

RUN curl -L https://github.com/github/hub/releases/download/v2.14.2/hub-linux-386-2.14.2.tgz --output hub.tgz && tar -xzf hub.tgz && mv hub-linux-386-2.14.2/bin/hub /usr/local/bin && rm hub.tgz && rm -rf hub-linux-386-2.14.2

RUN curl -L https://github.com/cli/cli/releases/download/v1.4.0/gh_1.4.0_linux_386.tar.gz --output gh.tar.gz \
  && tar -xzf gh.tar.gz \
  && mv gh_1.4.0_linux_386/bin/gh /usr/local/bin \
  && rm gh.tar.gz \
  && rm -rf gh_1.4.0_linux_386

ENTRYPOINT [ "semver-cli" ]
