# Windows 11 developer setup with WinGet + DSC v3 + VS Code + WSL

This bundle gives you a practical, ready-to-use setup for a Windows 11 development machine focused on:

- Visual Studio Code
- WSL / Ubuntu
- VS Code extensions for WSL, Containers, Terraform, YAML, PowerShell, GitHub Copilot
- Git / Windows Terminal / PowerShell 7 / Azure CLI / Podman Desktop
- A follow-up Ubuntu bootstrap script for your WSL distro

> Notes
>
> - The WinGet configuration approach is declarative and idempotent in general.
> - The WSL distro bootstrap still needs one interactive Linux user creation step after `wsl --install`.
> - VS Code's WSL workflow installs VS Code Server inside WSL on first `code .` launch.
> - This configuration uses a practical mix of WinGet package resources and command resources for steps that are easier to express as commands.

## Files in this bundle

- `dev-setup.v3.winget` -> WinGet / DSC v3 configuration for Windows-side setup
- `bootstrap-ubuntu-dev.sh` -> Ubuntu bootstrap script to run inside WSL after first launch
- `README.md` -> this guide

## Prerequisites

Run PowerShell **as Administrator**.

Recommended checks:

```powershell
winget --version
wsl --version
```

If you want the newer DSC v3 processor available:

```powershell
winget install --id Microsoft.DSC -e
```

## Apply the Windows-side configuration

From the folder containing these files:

```powershell
winget configure --file .\dev.v3.winget --accept-configuration-agreements --nowarn
```

## What the Windows-side config does

- Installs core tools with WinGet:
  - Git
  - Windows Terminal
  - PowerShell 7
  - Azure CLI
  - Podman Desktop
  - Visual Studio Code
  - WSL package
- Installs VS Code with context-menu tasks via installer override
- Installs useful VS Code extensions
- Enables/install WSL and Ubuntu 24.04 if needed

## After Windows-side config completes

### 1) Reboot if prompted

WSL installation may require a reboot.

### 2) Complete Ubuntu first-run

Start Ubuntu once:

```powershell
wsl -d Ubuntu-24.04
```

Create your Linux user when prompted.

### 3) Copy and run the Ubuntu bootstrap script

If your current directory is reachable from Windows, you can call the script from inside Ubuntu via `/mnt/c/...`.

Example:

```bash
cd /mnt/c/Users/<YourUser>/Downloads
chmod +x bootstrap-ubuntu-dev.sh
./bootstrap-ubuntu-dev.sh
```

Or place it anywhere inside your Linux home and run:

```bash
chmod +x bootstrap-ubuntu-dev.sh
./bootstrap-ubuntu-dev.sh
```

### 4) Open your repo from WSL in VS Code

Inside Ubuntu:

```bash
cd ~/src
mkdir -p demo
cd demo
code .
```

On first run, VS Code installs the server components in WSL automatically.

## Useful follow-up commands

### Verify VS Code context menu install

The config installs VS Code using installer tasks for:

- file context menu
- folder context menu

If Windows 11 hides it, look under **Show more options**.

### Verify installed extensions

```powershell
code --list-extensions
```

### Check WSL distributions

```powershell
wsl --list --verbose
```

### Open an Ubuntu shell quickly

```powershell
wsl -d Ubuntu-24.04
```

## Suggested workflow for your setup

This matches the WSL-first approach:

1. Keep repositories in Linux, e.g. `~/src/...`
2. Open them from Ubuntu with `code .`
3. Use Windows-side VS Code UI, but Linux-side tools/runtime
4. Use Podman / other tooling only where really needed on Windows

## Optional additions you may want later

You can extend the WinGet config with:

- `Microsoft.VisualStudio.2022.Community` or another Visual Studio edition
- `Terraform.Terraform`
- `Hashicorp.Packer`
- `OpenJS.NodeJS.LTS`
- `Python.Python.3.12`
- `Docker.DockerDesktop` (if you decide not to use Podman)
- `GitHub.cli`

## Troubleshooting

### `code` not found in WSL

Open VS Code from Windows once, then retry `code .` in WSL.

### VS Code installs but context menu is missing

Re-run the install override directly:

```powershell
winget install --id Microsoft.VisualStudioCode -e --override "/VERYSILENT /NORESTART /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders"
```

### `wsl --install -d Ubuntu-24.04` fails because WSL already exists

Try:

```powershell
wsl --list --online
wsl --install -d Ubuntu-24.04
```

### Extension install warnings in WSL

Some extensions must be installed **inside WSL** as well. VS Code usually shows an **Install in WSL** button.

---

If you want, you can next adapt this bundle for one of these profiles:

- **minimal WSL + VS Code only**
- **Azure / Terraform workstation**
- **Podman + Dev Containers workstation**
- **corporate laptop with strict least-change defaults**
