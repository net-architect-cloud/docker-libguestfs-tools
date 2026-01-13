<div id="top"></div>

<!-- PROJECT SHIELDS -->
<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPL-3.0 License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

</div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Net-Architect-Cloud/docker-libguestfs-tools">
    <img src="images/logo.svg" alt="Logo" width="250">
  </a>

<h3 align="center">LibGuestFS Container</h3>

  <p align="center">
    Docker container with libguestfs, qemu and image manipulation tools
    <br />
    <a href="https://github.com/Net-Architect-Cloud/docker-libguestfs-tools"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/issues">Report Bug</a>
    ·
    <a href="https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#environment-variables">Environment Variables</a></li>
    <li><a href="#supported-formats">Supported Formats</a></li>
    <li><a href="#troubleshooting">Troubleshooting</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This project provides a Docker image containing libguestfs, qemu, and other essential tools for virtual machine image manipulation. Based on Rocky Linux 10 UBI, this container is optimized for size and performance while offering the full functionality of libguestfs and associated tools.

### Key Features

- ✅ Ready-to-use libguestfs configuration with direct backend
- 🗂️ Support for multiple filesystem formats (ext4, XFS, BTRFS, NTFS, FAT)
- 🛠️ Comprehensive tools for converting, manipulating, and analyzing virtual images
- 🚀 Lightweight container image with aggressive cleanup of unnecessary dependencies
- 🔧 Pre-configured environment variables for optimal performance

### Use Cases

This container is ideal for:
- CI/CD pipelines requiring VM image manipulation
- Development environments needing image conversion tools
- Automation tools for virtualized infrastructure management
- Image analysis and forensics workflows

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

- Docker installed on your system (version 20.10 or later recommended)
- Sufficient disk space for your VM images
- Basic knowledge of libguestfs tools
- For advanced operations: Docker with `--privileged` flag support
- Optional: `/dev/kvm` access for better performance with nested virtualization

### Installation

Pull the image from GitHub Container Registry:
```bash
docker pull ghcr.io/net-architect-cloud/docker-libguestfs-tools:latest
```

### Building Locally

To build the image yourself:
```bash
git clone https://github.com/Net-Architect-Cloud/docker-libguestfs-tools.git
cd docker-libguestfs-tools
docker build -t libguestfs-tools:local .
```

### Using Docker Compose

A `docker-compose.yml` file is provided for easier container management:

```bash
docker-compose run --rm libguestfs-tools bash
```

Or run specific commands:
```bash
docker-compose run --rm libguestfs-tools virt-df -a /workspace/images/my-vm.qcow2
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

### Basic Usage

1. **Mount a volume to share images with the container**
   ```bash
   docker run -v /local/path/images:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools virt-df -a /workspace/images/my-vm.qcow2
   ```

2. **Run libguestfs tools interactively**
   ```bash
   docker run -it -v /local/path/images:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools bash
   ```

3. **Execute specific commands**
   ```bash
   docker run -v /local/path/images:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools \
     virt-customize -a /workspace/images/my-vm.qcow2 --install nginx
   ```

### Advanced Examples

#### Converting VMware to qcow2 format

```bash
docker run -v /local/path/images:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools \
  virt-v2v -i ova /workspace/images/source-vm.ova -o local -os /workspace/images -of qcow2
```

#### Inspecting a VM image

```bash
docker run -v /local/path/images:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools \
  virt-inspector /workspace/images/my-vm.qcow2
```

#### Resizing a disk image

```bash
docker run -v /local/path/images:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools \
  qemu-img resize /workspace/images/my-vm.qcow2 +10G
```

#### Mounting and exploring filesystem

```bash
docker run -it --privileged -v /local/path/images:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools \
  guestmount -a /workspace/images/my-vm.qcow2 -m /dev/sda1 /mnt
```

### Example Scripts

The `examples/` directory contains ready-to-use shell scripts for common operations:

- **convert-vmdk-to-qcow2.sh** - Convert VMware images to QCOW2 format
- **inspect-vm-image.sh** - Inspect VM images for OS and application details
- **customize-vm.sh** - Customize VM images by installing packages

See the [examples/README.md](examples/README.md) for detailed usage instructions.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ENVIRONMENT VARIABLES -->
## Environment Variables

The container is configured with the following environment variables for libguestfs:

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `LIBGUESTFS_BACKEND` | `direct` | Uses direct backend (no nested VM) |
| `LIBGUESTFS_DEBUG` | `0` | Set to `1` to enable debug output |
| `LIBGUESTFS_TRACE` | `0` | Set to `1` to enable function tracing |
| `LIBGUESTFS_PROGRESS` | `1` | Shows progress bars during operations |
| `LIBGUESTFS_VERBOSE` | `0` | Set to `1` for verbose output |
| `LIBGUESTFS_MEMSIZE` | `4096` | Memory size in MB for libguestfs appliance |
| `LIBGUESTFS_SMP` | `4` | Number of virtual CPUs for libguestfs appliance |

### Overriding Environment Variables

You can override these values when running the container:

```bash
docker run -e LIBGUESTFS_VERBOSE=1 -e LIBGUESTFS_DEBUG=1 \
  -v /local/path:/workspace/images \
  ghcr.io/net-architect-cloud/docker-libguestfs-tools
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- SUPPORTED FORMATS -->
## Supported Formats

### Input Formats
- VMware (OVA, VMDK)
- VirtualBox (VDI)
- Hyper-V (VHD, VHDX)
- qcow2
- Raw disk images

### Output Formats
- qcow2 (recommended for KVM/OpenStack)
- VMDK (for VMware)
- VDI (for VirtualBox)
- Raw disk images

### Filesystem Support
- Linux: ext2, ext3, ext4, XFS, BTRFS
- Windows: NTFS, FAT32
- Others: ISO9660, UDF

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- TROUBLESHOOTING -->
## Troubleshooting

### Common Issues

**Permission denied errors:**
```bash
# Run with --privileged flag for advanced operations
docker run --privileged -v /local/path:/workspace/images ghcr.io/net-architect-cloud/docker-libguestfs-tools
```

**Enable verbose output for debugging:**
```bash
docker run -e LIBGUESTFS_VERBOSE=1 -e LIBGUESTFS_DEBUG=1 \
  -v /local/path:/workspace/images \
  ghcr.io/net-architect-cloud/docker-libguestfs-tools
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

### How to Contribute

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Don't forget to give the project a star! ⭐ Thanks again!

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the GPL-3.0 License. See [`LICENSE`](LICENSE) for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

**Kevin Allioli**
- Twitter: [@netarchitect](https://twitter.com/netarchitect)
- Email: kevin@netarchitect.cloud
- LinkedIn: [kevinallioli](https://linkedin.com/in/kevinallioli)

**Project Links:**
- Repository: [https://github.com/Net-Architect-Cloud/docker-libguestfs-tools](https://github.com/Net-Architect-Cloud/docker-libguestfs-tools)
- Issues: [Report a Bug](https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/issues)
- Container Registry: [ghcr.io/net-architect-cloud/docker-libguestfs-tools](https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/pkgs/container/docker-libguestfs-tools)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Net-Architect-Cloud/docker-libguestfs-tools.svg?style=for-the-badge
[contributors-url]: https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Net-Architect-Cloud/docker-libguestfs-tools.svg?style=for-the-badge
[forks-url]: https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/network/members
[stars-shield]: https://img.shields.io/github/stars/Net-Architect-Cloud/docker-libguestfs-tools.svg?style=for-the-badge
[stars-url]: https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/stargazers
[issues-shield]: https://img.shields.io/github/issues/Net-Architect-Cloud/docker-libguestfs-tools.svg?style=for-the-badge
[issues-url]: https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/issues
[license-shield]: https://img.shields.io/github/license/Net-Architect-Cloud/docker-libguestfs-tools.svg?style=for-the-badge
[license-url]: https://github.com/Net-Architect-Cloud/docker-libguestfs-tools/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/kevinallioli
