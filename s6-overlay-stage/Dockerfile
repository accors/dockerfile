ARG S6_VERSION
ARG S6_ARCH

# Download, unpack, and verify S6 Overlay
FROM alpine:3.11 as build
WORKDIR /tmp
RUN  apk add --no-cache \
  curl \
  gnupg 

ARG S6_VERSION
ARG S6_ARCH
  
RUN curl \
    --location \
    --output "s6-overlay-${S6_ARCH}.tar.gz" \
    "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz" \
  \
  && curl \
    --location \
    --output "s6-overlay-${S6_ARCH}.tar.gz.sig" \
    "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz.sig" \
  \
  && curl \
    --location \
    --output "key.asc" \
    "https://keybase.io/justcontainers/key.asc" \
  \
  && gpg --import ./key.asc \
  && gpg --verify "s6-overlay-${S6_ARCH}.tar.gz.sig" "s6-overlay-${S6_ARCH}.tar.gz" \
  && mkdir /out \
  && tar xfz "s6-overlay-${S6_ARCH}.tar.gz" -C /out \
  && rm -rf /tmp/*

# Copy the validated, unpacked S6 overlay
FROM scratch
COPY --from=build /out /