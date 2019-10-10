# Build
FROM elixir:1.9.1-alpine AS builder

ENV MIX_ENV=prod \
    PORT=9091

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app

COPY config ./config
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

RUN mix deps.get
RUN mix deps.compile
RUN mix release

# Application
FROM alpine:latest as app

RUN apk update && apk upgrade && \
    apk add --no-cache bash make wget build-base

EXPOSE 9091

RUN addgroup -S app && adduser -S app -G app -h /app
WORKDIR /app
COPY --from=builder /app/_build .
RUN chown -R app: ./prod
USER app

# Run the app
CMD ["./prod/rel/tic_tac_toe/bin/tic_tac_toe", "start"]

