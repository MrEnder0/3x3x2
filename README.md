<img src=".github/assets/banner.png">

A esoteric interpreted language made in Nim based on a 3x3 grid of zeros and ones.

[![Nightly Release](https://github.com/MrEnder0/Grid9/actions/workflows/nightly.yml/badge.svg)](https://github.com/MrEnder0/Grid9/actions/workflows/nightly.yml)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/MrEnder0/Grid9)

## Installation

### Binaries

Download the latest release for your platform from the releases page.

### Self Build

#### Windows

Make sure git is installed then run this command.

```powershell
powershell.exe $code = Invoke-RestMethod "https://raw.githubusercontent.com/MrEnder0/Grid9/main/scripts/install_windows.ps1"; foreach($a in $code) {iex $a;}
```

#### Linux

Make sure curl is installed then run this command.

```bash
curl -s https://raw.githubusercontent.com/MrEnder0/Grid9/main/scripts/install_linux.sh | bash
```

### Online

You can [run this project in gitpod](https://gitpod.io/#https://github.com/MrEnder0/Grid9) if you dont want to run it locally.

## Documentation

The docs are accessible by running "grid9 d" in the terminal or by going to the online documentation [here](https://mrender0.github.io/Grid9/).

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[gpl-3.0](https://choosealicense.com/licenses/lgpl-3.0/)

## Credits

This project was inspired by the [BrainFuck](https://esolangs.org/wiki/Brainfuck) project on esolangs.org.
