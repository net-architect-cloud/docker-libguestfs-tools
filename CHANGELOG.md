# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `.dockerignore` file to optimize build context
- `CHANGELOG.md` for tracking project changes
- Documentation improvements in README

### Changed
- Updated README with missing environment variables (`LIBGUESTFS_MEMSIZE`, `LIBGUESTFS_SMP`)
- Fixed incomplete command example in README
- Corrected LICENSE link in README badges

### Fixed
- Fixed broken LICENSE URL reference in README

## [1.0.0] - Initial Release

### Added
- Docker image based on Rocky Linux 10 UBI
- LibGuestFS tools and utilities
- QEMU tools for image manipulation
- Support for multiple filesystem formats (ext4, XFS, BTRFS, NTFS, FAT)
- Virt-v2v for VM conversion
- Comprehensive documentation
- GitHub Actions workflow for automated builds
