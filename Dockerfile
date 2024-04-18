FROM hypriot/image-builder:latest

# Enable better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update || (echo "apt-get update failed with exit code $?" && cat /var/lib/apt/lists/* 2>/dev/null && false) && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binfmt-support \
    qemu \
    qemu-user-static \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
COPY builder/ /builder/

# build sd card image
CMD /builder/build.sh
