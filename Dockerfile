FROM golang:1-alpine AS build
ARG REPO=github.com/devopy.io/loginapp

RUN apk add --no-cache git build-base
COPY . /go/src/${REPO}
WORKDIR /go/src/${REPO}
RUN make build-static

FROM scratch
ARG REPO=github.com/devopy.io/loginapp

COPY --from=build /go/src/${REPO}/bin/loginapp-static /loginapp
COPY --from=build /go/src/${REPO}/assets /assets
COPY --from=build /go/src/${REPO}/templates /templates

ENTRYPOINT ["/loginapp"]
CMD [""]
