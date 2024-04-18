FROM hypriot/image-builder:latest

# Enable better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Replace stretch sources with bookworm in sources.list
RUN sed -i 's/stretch/bookworm/g' /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binfmt-support \
    qemu \
    qemu-user-static \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY builder/ /builder/

# build sd card image
CMD /builder/build.sh
