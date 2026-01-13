#!/bin/bash
# Example: Customize a VM image (install packages, run commands)

set -e

IMAGE_DIR="${IMAGE_DIR:-./images}"
IMAGE_FILE="${1:-vm-image.qcow2}"

echo "Customizing $IMAGE_FILE..."

docker run --rm \
  -v "$IMAGE_DIR:/workspace/images" \
  ghcr.io/net-architect-cloud/docker-libguestfs-tools:latest \
  virt-customize -a "/workspace/images/$IMAGE_FILE" \
  --install nginx,curl \
  --run-command "systemctl enable nginx" \
  --root-password password:changeme

echo "Customization complete!"
