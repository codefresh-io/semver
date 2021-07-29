FROM golang:alpine3.14 as go

RUN apk add --update git

RUN go get github.com/davidrjonas/semver-cli

FROM alpine:3.14

RUN apk add --update ca-certificates git curl jq py-pip bash && pip install yq

COPY --from=go /go/bin/semver-cli /usr/local/bin/semver-cli

ARG HUB_VERSION=2.14.2
RUN curl -L https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-386-${HUB_VERSION}.tgz --output hub.tgz \
  && tar -xzf hub.tgz \
  && mv hub-linux-386-${HUB_VERSION}/bin/hub /usr/local/bin \
  && rm hub.tgz \
  && rm -rf hub-linux-386-${HUB_VERSION}

ARG GH_VERSION=1.13.1
RUN curl -L https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz --output gh.tar.gz \
  && tar -xzf gh.tar.gz \
  && mv gh_${GH_VERSION}_linux_amd64/bin/gh /usr/local/bin \
  && rm gh.tar.gz \
  && rm -rf gh_${GH_VERSION}_linux_amd64

ENTRYPOINT [ "semver-cli" ]
