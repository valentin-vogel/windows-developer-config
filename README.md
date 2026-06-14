# Windows Developer Config

Opinionated setups for Windows dev boxes and workstations. Idempotent.

---

Go from a fresh Windows install to a fully configured dev box in one command. These declarative configs set up your tools, settings, and shells the same way every time.

## 🎯 Pick your setup

Three developer setups live in this repo:

| You want...                                                                         | Go to                                               |
| ----------------------------------------------------------------------------------- | --------------------------------------------------- |
| A complete dev workstation: tools, OS settings, WSL, and terminal.                  | [Windows Dev Config](#%EF%B8%8F-windows-dev-config) |
| A polished WSL shell: zsh/bash, Starship, CLI tools, and a themed terminal profile. | [WSL Comfort](#-wsl-comfort)                        |
| A single language toolchain: Typescript, Azure. One command each.                   | [Workloads](#-single-language-workloads)            |

Most of them use [`winget configure`](https://learn.microsoft.com/en-us/windows/package-manager/winget/configure). If you've never used it before, enable it once:

```powershell
winget configure --enable
```

## 🖥️ Windows Dev Config

_Turns a fresh Windows 11 into a clean, distraction-free dev workstation in one shot._

A single [winget configuration](https://learn.microsoft.com/en-us/windows/package-manager/configuration/) file that installs dev tools, applies opinionated Windows settings, and bootstraps WSL + Ubuntu through the required reboot. Non-interactive. Idempotent. Safe to re-run on an existing machine.

```powershell
winget configure -f .\windows-dev-config\dev.winget --accept-configuration-agreements --disable-interactivity
```

> ⚠️ **May reboot.** Enabling WSL needs a Windows optional feature that requires a restart. A `RunOnce` task picks the configuration back up after you sign in, installs Ubuntu, and finishes the run.

What is included:

- **Dev tools:** PowerShell 7, Git, GitHub CLI, VS Code, .NET SDK 10, Python 3.14 + uv, Node.js, Oh My Posh, and PowerToys.
- **Terminal:** PowerShell 7 is the default profile, Oh My Posh is enabled, and Cascadia Mono NF is set as the default font.
- **Windows settings:** Dark theme, developer mode, long paths, File Explorer defaults, Start/Search cleanup, Edge policies, and other workstation defaults.
- **WSL:** WSL platform + Ubuntu, including the reboot and the `RunOnce` resume step.

Full details: [`windows-dev-config/README.md`](./windows-dev-config/README.md).

## 🐧 WSL Comfort Shell

WSL Comfort runs inside the wsl distro and configures the shell standalone. Copy `comfort-shell-bootstrap.sh` onto any Ubuntu wsl host and run it.

What you can pick

- Your choice of shell: **zsh** or **bash**.
- Optional **Starship** prompt.
- Optional modern CLI tools: `fzf`, `rg`, `fd`, `bat`, `eza`, `zoxide`, `jq`.
- Optional clipboard and `open` shims (`pbcopy`, `pbpaste`, `open`).
- Optional **Homebrew**.
- Optional Git defaults.

Full details: [`wsl-comfort/readme.md`](./wsl-comfort/README.md).

## 🧪 Single-language workloads

Just want one toolchain? Each workload ships a `config.winget` file.

| Workload   | Installs                                              |
| ---------- | ----------------------------------------------------- |
| TypeScript | Node LTS + NVM                                        |
| Azure      | AzureCLI + Azure Storage Explorer + Azure Data Studio |

Example: For Typescript workloads run `winget configure -f .\Workloads\typescript\config.winget --accept-configuration-agreements --disable-interactivity`.

## ❤️ Contributing

Contributions of all kinds are welcome.
