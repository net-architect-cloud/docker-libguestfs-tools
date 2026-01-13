# Base image: Rocky Linux 10 UBI
FROM rockylinux/rockylinux:10-ubi-init

# Maintainer information
LABEL maintainer="kevin@netarchitect.cloud"
LABEL description="Container with libguestfs, qemu and image manipulation tools"

# Environment configuration for libguestfs
ENV LIBGUESTFS_BACKEND=direct \
    LIBGUESTFS_DEBUG=0 \
    LIBGUESTFS_TRACE=0 \
    LIBGUESTFS_PROGRESS=1 \
    LIBGUESTFS_VERBOSE=0 \
    LIBGUESTFS_MEMSIZE=4096 \
    LIBGUESTFS_SMP=4

# Installing dependencies and cleaning up in a single step to reduce image size
RUN microdnf -y install dnf && \
    dnf -y update && \
    dnf -y install --allowerasing --setopt=install_weak_deps=False --nodocs \
        # Virtualization tools
        qemu-img \
        qemu-kvm \
        libguestfs \
        libguestfs-tools-c \
        virt-v2v \
        libvirt-daemon-kvm \
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
    microdnf clean all && \
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
