# Makefile for building Catatan Struktur Bilangan Bulat LaTeX project
# Copyright©2019 Valerian Mahdi Pratama

# Configuration
MAIN = MainFile
LATEX = pdflatex
LATEX_FLAGS = -interaction=nonstopmode -halt-on-error
OUTPUT_DIR = build
FINAL_PDF = $(MAIN).pdf

# Source files
SOURCES = $(MAIN).tex Bab1.tex Bab2.tex Bab3.tex Bab4.tex Pengantar.tex Notasi.tex Apendiks.tex

# LaTeX packages that need to be installed
REQUIRED_PACKAGES = amsmath amsfonts amsthm amssymb graphicx tikz-cd adjustbox

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
NC = \033[0m # No Color

.PHONY: all clean check-deps install-deps help

# Default target
all: check-deps $(FINAL_PDF)

# Help target
help:
	@echo "$(GREEN)Makefile for Catatan Struktur Bilangan Bulat$(NC)"
	@echo ""
	@echo "Available targets:"
	@echo "  $(YELLOW)make$(NC)           - Check dependencies and build the PDF"
	@echo "  $(YELLOW)make build$(NC)     - Build the PDF (assumes dependencies are installed)"
	@echo "  $(YELLOW)make clean$(NC)     - Remove all build artifacts"
	@echo "  $(YELLOW)make check-deps$(NC) - Check if required LaTeX packages are installed"
	@echo "  $(YELLOW)make install-deps$(NC) - Show instructions for installing dependencies"
	@echo "  $(YELLOW)make help$(NC)      - Show this help message"
	@echo ""

# Check if required LaTeX tools are installed
check-deps:
	@echo "$(YELLOW)Checking for required dependencies...$(NC)"
	@command -v $(LATEX) >/dev/null 2>&1 || \
		{ echo "$(RED)Error: pdflatex is not installed!$(NC)"; \
		  echo "$(YELLOW)Run 'make install-deps' for installation instructions.$(NC)"; \
		  exit 1; }
	@echo "$(GREEN)✓ pdflatex found$(NC)"
	@echo "$(GREEN)All required tools are installed!$(NC)"
	@echo ""

# Show installation instructions
install-deps:
	@echo "$(YELLOW)LaTeX Installation Instructions:$(NC)"
	@echo ""
	@echo "$(GREEN)For Ubuntu/Debian:$(NC)"
	@echo "  sudo apt-get update"
	@echo "  sudo apt-get install texlive-latex-base texlive-latex-extra texlive-fonts-recommended"
	@echo ""
	@echo "$(GREEN)For macOS (with Homebrew):$(NC)"
	@echo "  brew install --cask mactex"
	@echo "  # Or for a smaller installation:"
	@echo "  brew install --cask basictex"
	@echo ""
	@echo "$(GREEN)For Arch Linux:$(NC)"
	@echo "  sudo pacman -S texlive-core texlive-latexextra"
	@echo ""
	@echo "$(GREEN)For Fedora/RHEL:$(NC)"
	@echo "  sudo dnf install texlive-scheme-basic texlive-latex texlive-amsmath texlive-tikz-cd"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) After installation, you may need to restart your terminal."
	@echo ""

# Build the PDF
$(FINAL_PDF): $(SOURCES)
	@echo "$(YELLOW)Building PDF from LaTeX sources...$(NC)"
	@mkdir -p $(OUTPUT_DIR)
	@echo "$(GREEN)Running pdflatex (first pass)...$(NC)"
	@$(LATEX) $(LATEX_FLAGS) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	@echo "$(GREEN)Running pdflatex (second pass for references)...$(NC)"
	@$(LATEX) $(LATEX_FLAGS) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	@echo "$(GREEN)Running pdflatex (third pass for TOC)...$(NC)"
	@$(LATEX) $(LATEX_FLAGS) -output-directory=$(OUTPUT_DIR) $(MAIN).tex
	@cp $(OUTPUT_DIR)/$(FINAL_PDF) .
	@echo "$(GREEN)✓ Build complete! PDF created: $(FINAL_PDF)$(NC)"

# Alternative build target
build: $(FINAL_PDF)

# Clean build artifacts
clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf $(OUTPUT_DIR)
	@rm -f $(MAIN).pdf
	@rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz
	@echo "$(GREEN)✓ Clean complete!$(NC)"
