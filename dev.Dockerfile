ARG MIX_ENV="prod"

# build stage
FROM hexpm/elixir:1.12.3-erlang-24.1.2-alpine-3.14.2 AS build

# install build dependencies
RUN apk add --no-cache build-base git python3 curl

# sets work dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

# copy compile configuration files
RUN mkdir config
COPY config/config.exs config/$MIX_ENV.exs config/

# compile dependencies
RUN mix deps.compile

# copy assets
COPY priv priv

# compile project
COPY lib lib
RUN mix compile

COPY entrypoint.sh entrypoint.sh

RUN ls -la

# copy runtime configuration file
COPY config/runtime.exs config/

# assemble release
RUN mix release

# app stage
FROM alpine:3.9 AS app

RUN apk add --no-cache openssl ncurses-libs bash libgcc libstdc++

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/todo ./

COPY entrypoint.sh entrypoint.sh

ENV HOME=/app

CMD ["./entrypoint.sh"]
