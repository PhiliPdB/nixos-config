# NixOS Config

This repository contains my personal NixOS config.
I recently started learning Nix and NixOS, so there might be some less ideal things going on.
Feel free to open a discussion or issue on how I could improve certain parts.


## Project structure
The folder structure of the project is as follows:
```
.
├── dotfiles/       <- Dotfiles for specific programs not configured via Nix
├── hosts/          <- Machine specific configuration
│   └── <machine-name>/
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── home.nix
├── modules/        <- General nix modules for reusable configuration between hosts
│   ├── system/     <- NixOS configuration modules
│   └── user/       <- Home manager configuration modules
├── scripts/        <- Some maybe useful scripts
├── themes/         <- Extra theming configuration and definitions
└── wallpapers/     <- Provided wallpapers
```


## Licenses [![MIT][mit-shield]](./LICENSE) [![CC BY-NC-ND 4.0][cc-by-nc-nd-shield]][cc-by-nc-nd]
The main config is licensed under the [MIT License](./LICENSE).

The provided wallpapers (in [`./wallpapers`](./wallpapers)) are my own pictures and licensed under the Creative Commons CC-BY-NC-ND license. See also the wallpapers [README](./wallpapers/README.md) and [LICENSE](./wallpapers/LICENSE) files.


[mit-shield]: https://img.shields.io/badge/License-MIT-green.svg
[cc-by-nc-nd]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[cc-by-nc-nd-shield]: https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg
