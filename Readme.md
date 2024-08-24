
# System Management Scripts

This repository contains four powerful Bash scripts that assist in managing various system-level tasks such as monitoring resources, managing network interfaces, handling processes, and managing users and groups. Each script is designed with simplicity and usability in mind, providing essential functions for system administrators and users.

## Scripts Overview

### 1. `monitor.sh`

**Purpose**: 
This script provides system monitoring functionalities, helping you keep an eye on your system's CPU, memory, and disk usage. It's a handy tool to understand resource consumption and manage performance.

**Usage**:
```bash
sudo ./monitor.sh <option>
```

**Options**:
- `cpu` - Display CPU usage information, including user, system, and idle percentages.
- `memory` - Display memory usage, including total, used, and free memory.
- `disk` - Display disk usage for mounted file systems.
- `all` - Display CPU, memory, and disk usage together.
- `--help` - Display usage information and available options.

**Examples**:
- To monitor CPU usage:
  ```bash
  sudo ./monitor.sh cpu
  ```
- To check all system resources:
  ```bash
  sudo ./monitor.sh all
  ```

### 2. `network.sh`

**Purpose**: 
This script handles network management tasks such as configuring network interfaces, setting IP addresses, managing gateways, and displaying network statuses. It's an essential tool for network administrators.

**Usage**:
```bash
sudo ./network.sh <command> [options]
```

**Commands**:
- `up <interface>` - Bring a network interface up (e.g., `eth0`).
- `down <interface>` - Bring a network interface down.
- `ip <interface> <address>` - Assign an IP address to a network interface.
- `gw <address>` - Set a default gateway for the network.
- `delgw <address>` - Remove a default gateway.
- `restart` - Restart the network service to apply changes.
- `status` - Show the status of all network interfaces.
- `route` - Display the routing table.
- `--help` - Display usage information and available commands.

**Examples**:
- To bring an interface up:
  ```bash
  sudo ./network.sh up eth0
  ```
- To assign an IP address to an interface:
  ```bash
  sudo ./network.sh ip eth0 192.168.1.10
  ```

### 3. `manage.sh`

**Purpose**: 
This script allows for process management, enabling you to list running processes, kill processes by PID or name, change process priorities (nice values), and view detailed process information.

**Usage**:
```bash
sudo ./manage.sh <option>
```

**Options**:
- `list` - List all running processes sorted by CPU usage.
- `kill <pid>` - Terminate a process by its PID.
- `killname <name>` - Terminate all processes by their name.
- `priority <pid> <priority>` - Change the priority of a process (lower values mean higher priority).
- `info <pid>` - Get detailed information about a specific process, including memory and CPU usage.
- `--help` - Display usage information and available options.

**Examples**:
- To list the top 20 running processes by CPU usage:
  ```bash
  sudo ./manage.sh list
  ```
- To kill a process by PID:
  ```bash
  sudo ./manage.sh kill 1234
  ```

### 4. `ch.sh`

**Purpose**: 
This script facilitates user and group management, offering functionalities such as adding/deleting users or groups, changing user shells, renaming users/groups, and managing group memberships.

**Usage**:
```bash
sudo ./ch.sh <u/g> <option>
```

**Options for Users (u)**:
- `add <name>` - Add a new user with a home directory and default shell.
- `delete <name>` - Delete an existing user.
- `shell <name> <shellLoc>` - Change the default shell for a user.
- `super <name>` - Grant a user superuser privileges by adding them to the `sudo` group.
- `rename <oldName> <newName>` - Rename a user and update their home directory.
- `adduser <uname> <gname>` - Add a user to a group.
- `--help` - Display usage information and available options.

**Options for Groups (g)**:
- `add <name>` - Create a new group.
- `delete <name>` - Remove an existing group.
- `rename <oldName> <newName>` - Rename a group.
- `--help` - Display usage information and available options.

**Examples**:
- To add a new user:
  ```bash
  sudo ./ch.sh u add newuser
  ```
- To delete a group:
  ```bash
  sudo ./ch.sh g delete oldgroup
  ```

## Prerequisites

- You must have superuser privileges to execute these scripts (`sudo` access).
- These scripts are designed for Unix-like operating systems (Linux).

## Installation

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/system-management-scripts.git
   cd system-management-scripts
   ```

2. Make the scripts executable:
   ```bash
   chmod +x monitor.sh network.sh manage.sh ch.sh
   ```

## Contributing

If you would like to contribute to this project, feel free to fork the repository, make changes, and submit a pull request. Contributions are welcome!

## Contact

For any questions or issues, please contact [suraj00415@gmail.com](mailto:suraj00415@gmail.com).
