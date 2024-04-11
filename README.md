# Script Repository

This repository contains a collection of Bash scripts designed to facilitate various system administration tasks. Each script serves a specific purpose, from system monitoring to file management.

## Scripts

### `backup.sh`

Creates a backup of a specified directory.

**Usage:**
```bash
./backup.sh source_directory target_directory
```

### `dirsize.sh`

Lists the sizes of directories in a specified directory, sorted from largest to smallest.

**Usage:**
```bash
./dirsize.sh [directory]
```

### `imageresize.sh`

Resizes all images in a directory to a specified width while maintaining aspect ratio.

**Usage:**
```bash
./imageresize.sh directory new_width
```

### `maxsize.sh`

Finds and lists the largest files and directories within a specified directory.

**Usage:**
```bash
./maxsize.sh [-n number] [directory]
```

### `portscan.sh`

Scans and lists all open ports on the local machine along with the applications listening on these ports.

**Usage:**
```bash
./portscan.sh
```

### `procwatch.sh`

Monitors a specified process and provides real-time updates.

**Usage:**
```bash
./procwatch.sh process_name
```

### `sysinfo.sh`

Gathers and displays information about the system's current state, including memory usage, disk space, and running processes.

**Usage:**
```bash
./sysinfo.sh
```

## Installation

Clone the repository to your local machine using:

```bash
git clone [URL_TO_REPO]
```

Make the scripts executable:

```bash
chmod +x *.sh
```

## Running Scripts

To run any of the scripts, navigate to the cloned directory and execute the script with the required parameters as shown in the usage section for each script.

## License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.