<img src=".github/assets/banner.png">

A esoteric interpreted language made in Nim based on a 3x3 grid of zeros and ones.

[![Nightly Release](https://github.com/MrEnder0/Grid9/actions/workflows/nightly.yml/badge.svg)](https://github.com/MrEnder0/Grid9/actions/workflows/nightly.yml)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/MrEnder0/Grid9)

## Installation

### Binaries

Download the latest release from the releases page and run the installer.
Note: Seems that currently any version 2022-012 or newer will require nim to be installed on the system for Windows.

### Self Build

#### Windows

Make sure nim and git are installed then run this command.

```powershell
powershell.exe $code = Invoke-RestMethod "https://raw.githubusercontent.com/MrEnder0/Grid9/main/scripts/install_windows.ps1"; foreach($a in $code) {iex $a;}
```

#### Linux

Make sure curl is installed then run this command.

```bash
curl -s https://raw.githubusercontent.com/MrEnder0/Grid9/main/scripts/install_linux.sh | bash
```

### Test it out

You can open this project in gitpod if you dont want to run it locally.

## Future plans

Note in between updates there may be other smaller changes. Also none of these are in any particular order.

### High priority

- Allow certain commands to not have set character lengths.
- Make night release action create windows builds
- Make self build script download and install nim for you

### Low priority

- Add code blocks to the documentation.
