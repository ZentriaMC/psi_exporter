FROM rust AS builder

# Set up the toolchain
RUN rustup target add x86_64-unknown-linux-musl

# Copy dumb-init early
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /dumb-init
RUN chmod 755 /dumb-init

# Set up build environment
WORKDIR /build
RUN mkdir src && echo 'fn main() {}' > src/main.rs
COPY Cargo.toml Cargo.lock ./
RUN cargo fetch --locked
COPY . .
RUN cargo build --locked --offline --release --target x86_64-unknown-linux-musl
RUN cp ./target/x86_64-unknown-linux-musl/release/psi_exporter /psi_exporter

FROM scratch

COPY --from=builder /dumb-init /dumb-init
COPY --from=builder /psi_exporter /psi_exporter

ENTRYPOINT ["/dumb-init", "--", "/psi_exporter"]
CMD ["--web.listen-address", "0.0.0.0:9100"]
