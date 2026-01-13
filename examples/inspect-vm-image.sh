#!/bin/bash
# Example: Inspect a VM image to get OS and application information

set -e

IMAGE_DIR="${IMAGE_DIR:-./images}"
IMAGE_FILE="${1:-vm-image.qcow2}"

echo "Inspecting $IMAGE_FILE..."

docker run --rm \
  -v "$IMAGE_DIR:/workspace/images" \
  ghcr.io/net-architect-cloud/docker-libguestfs-tools:latest \
  virt-inspector -a "/workspace/images/$IMAGE_FILE"
