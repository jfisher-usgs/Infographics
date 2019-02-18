# Prerequisites:
#
#   install GNU Make https://www.gnu.org/software/make/
#   install GraphicsMagick http://www.graphicsmagick.org
#   install R https://www.r-project.org/
#   edit system PATH for command line access
#

DIR := .
DEN := 300
OPT := -trim -quality 100 +set date:create +set date:modify

all: convert render clean

convert:
	mkdir -p img;\
	for file in $(DIR)/*.ai; do \
		gm convert -density $(DEN) $$file $(OPT) $(DIR)/img/`basename --suffix=.ai $$file`.png;\
	done

render:
	Rscript $(DIR)/RenderGallery.R;\

clean:
	$(RM) -r $(DIR)/img;\
	$(RM) $(DIR)/index.Rmd;\

.PHONY: all convert render clean
