# builder
FROM rust:1.67 as builder

WORKDIR /usr/src/spotify-liked-transfer

COPY . .

RUN cargo install --path .

# app
FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates

COPY --from=builder /usr/local/cargo/bin/spotify-liked-transfer /usr/local/bin/spotify-liked-transfer

CMD ["spotify-liked-transfer"]
