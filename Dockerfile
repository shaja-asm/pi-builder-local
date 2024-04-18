FROM hypriot/image-builder:latest

# Enable better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Switch to Debian Bookworm repositories and add GPG keys
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binfmt-support \
    qemu-user-static \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*


COPY builder/ /builder/

# build sd card image
CMD /builder/build.sh
