# Base image: Rocky Linux 10 UBI
FROM rockylinux/rockylinux:10-ubi-init

# Maintainer and OCI labels
LABEL maintainer="kevin@netarchitect.cloud"
LABEL org.opencontainers.image.title="LibGuestFS Tools Container"
LABEL org.opencontainers.image.description="Container with libguestfs, qemu and image manipulation tools for VM image processing"
LABEL org.opencontainers.image.authors="Kevin Allioli <kevin@netarchitect.cloud>"
LABEL org.opencontainers.image.vendor="Net Architect Cloud"
LABEL org.opencontainers.image.licenses="GPL-3.0"
LABEL org.opencontainers.image.url="https://github.com/Net-Architect-Cloud/docker-libguestfs-tools"
LABEL org.opencontainers.image.source="https://github.com/Net-Architect-Cloud/docker-libguestfs-tools"
LABEL org.opencontainers.image.documentation="https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/blob/main/README.md"

# Environment configuration for libguestfs
ENV LIBGUESTFS_BACKEND=direct \
    LIBGUESTFS_DEBUG=0 \
    LIBGUESTFS_TRACE=0 \
    LIBGUESTFS_PROGRESS=1 \
    LIBGUESTFS_VERBOSE=0 \
    LIBGUESTFS_MEMSIZE=4096 \
    LIBGUESTFS_SMP=4

# Installing dependencies and cleaning up in a single step to reduce image size
RUN dnf -y update && \
    dnf -y install epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf -y install --allowerasing --setopt=install_weak_deps=False --nodocs \
        # Virtualization tools
        qemu-img \
        qemu-kvm \
        libguestfs \
        libguestfs-tools-c \
        virt-v2v \
        # System and network tools
        curl \
        tar \
        gzip \
        python3-libguestfs \
        # Filesystem tools - UPDATED VERSIONS
        e2fsprogs \
        xfsprogs \
        btrfs-progs \
        ntfs-3g \
        dosfstools \
        # Partition tools
        parted \
        gdisk \
        cloud-utils-growpart \
        # Miscellaneous tools
        openssh-clients \
        file \
        procps-ng \
        git \
        kmod \
        wget \
        iproute && \
    # Aggressive cleanup to reduce image size
    dnf clean all && \
    rm -rf /var/cache/dnf /var/cache/yum /var/log/* /tmp/* /var/tmp/* && \
    rm -rf /usr/share/{doc,man,info}/* && \
    # Create working directory
    mkdir -p /workspace/images /workspace/shared

# Define shared volume
VOLUME ["/workspace/shared"]

# Set working directory
WORKDIR /workspace

# Default entry point
CMD ["/bin/bash"]

