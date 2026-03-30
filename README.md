# Catatan-SBB
Catatan kuliah Struktur Bilangan Bulat di ITB

Copyright©2019 Valerian Mahdi Pratama

## Building the PDF

This project uses a Makefile to automate the build process. The Makefile will check for required dependencies before building.

### Quick Start

```bash
# Build the PDF (checks dependencies automatically)
make

# Or view all available commands
make help
```

### Available Commands

- `make` - Check dependencies and build the PDF
- `make build` - Build the PDF (assumes dependencies are installed)
- `make clean` - Remove all build artifacts
- `make check-deps` - Check if required LaTeX packages are installed
- `make install-deps` - Show instructions for installing dependencies
- `make help` - Show help message

### Installing Dependencies

If LaTeX is not installed on your system, run:

```bash
make install-deps
```

This will show installation instructions for your operating system.

**For Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install texlive-latex-base texlive-latex-extra texlive-fonts-recommended
```

**For macOS:**
```bash
brew install --cask mactex
```

**For Arch Linux:**
```bash
sudo pacman -S texlive-core texlive-latexextra
```

After installing dependencies, run `make` to build the PDF.
