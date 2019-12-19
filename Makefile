# Prepare package for release
#
# install GNU Make https://www.gnu.org/software/make/
# install GraphicsMagick http://www.graphicsmagick.org
# install R https://www.r-project.org/
# edit system PATH for command line access
#

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

DIR := .
DEN := 300
OPT := -trim -quality 100 +set date:create +set date:modify

all: convert render clean
.PHONY: all

convert:
	mkdir -p img
	for file in $(DIR)/*.ai; do \
		gm convert -density $(DEN) $$file $(OPT) $(DIR)/img/`basename --suffix=.ai $$file`.png
	done
.PHONY: convert

render:
	Rscript $(DIR)/RenderGallery.R
.PHONY: render

clean:
	$(RM) -r $(DIR)/img
	$(RM) $(DIR)/index.Rmd
.PHONY: clean
