FROM ghcr.io/gleam-lang/gleam:v1.0.0-erlang-slim


RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates
