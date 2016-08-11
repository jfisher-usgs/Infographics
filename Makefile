# Prerequisites:
#
#   install GNU Make https://www.gnu.org/software/make/
#   install GraphicsMagick http://www.graphicsmagick.org
#   install R https://www.r-project.org/
#   edit system PATH for command line access
#
# Targets: run using 'make <target>'
#
#   'all'    converts images from './*.ai' to './img/*.png',
#            creates './Gallery.md'
#   'clean'  removes './img' folder and its contents,
#            removes './Gallery.md' file
#

DIR := .
DEN := 300
OPT := -trim -quality 100 +set date:create +set date:modify

all: convert build

convert:
	mkdir -p img;\
	for file in $(DIR)/*.ai; do \
		gm convert -density $(DEN) $$file $(OPT) $(DIR)/img/`basename --suffix=.ai $$file`.png;\
	done

build:
	Rscript $(DIR)/BuildGallery

clean:
	$(RM) -r $(DIR)/img;\
	$(RM) $(DIR)/Gallery.md

.PHONY: all convert build clean
