FROM golang

RUN go get github.com/davidrjonas/semver-cli

ENTRYPOINT [ "semver-cli" ]