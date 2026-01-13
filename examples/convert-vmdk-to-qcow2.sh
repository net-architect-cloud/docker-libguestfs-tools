#!/bin/bash
# Example: Convert VMware VMDK to QCOW2 format

set -e

IMAGE_DIR="${IMAGE_DIR:-./images}"
SOURCE_IMAGE="${1:-source.vmdk}"
OUTPUT_IMAGE="${2:-output.qcow2}"

echo "Converting $SOURCE_IMAGE to $OUTPUT_IMAGE..."

docker run --rm \
  -v "$IMAGE_DIR:/workspace/images" \
  ghcr.io/net-architect-cloud/docker-libguestfs-tools:latest \
  qemu-img convert -f vmdk -O qcow2 \
  "/workspace/images/$SOURCE_IMAGE" \
  "/workspace/images/$OUTPUT_IMAGE"

echo "Conversion complete!"
echo "Output file: $IMAGE_DIR/$OUTPUT_IMAGE"
