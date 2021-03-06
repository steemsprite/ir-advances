BASENAME = slides
PDF = $(addsuffix .pdf, $(BASENAME))
TEX = $(addsuffix .tex, $(BASENAME))
PDFLATEX = pdflatex
OUT_DIR = texfiles
HIGHLIGHT_DIR = code

.PHONY: clean all

all: $(PDF)

$(PDF): $(TEX) sections/*.tex
	-test -d $(HIGHLIGHT_DIR) && make -C $(HIGHLIGHT_DIR)
	-test -d $(OUT_DIR) || mkdir $(OUT_DIR)
	# Twice, so TOC is also updated
	$(PDFLATEX) -output-directory $(OUT_DIR) $<
	$(PDFLATEX) -output-directory $(OUT_DIR) $<
	# In case of a different Beamer template folder
	#TEXINPUTS=$(STY_DIR)//: $(PDFLATEX) -output-directory $(OUT_DIR) $<
	cp $(OUT_DIR)/$(PDF) .

clean:
	-rm -rf $(OUT_DIR) *~
	-rm -f $(PDF)
