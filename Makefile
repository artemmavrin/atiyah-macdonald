LATEX := pdflatex
LATEXFLAGS := --shell-escape --file-line-error

LATEXMK := latexmk
LATEXMKFLAGS := -quiet -recorder -use-make -pdf

MAIN := solutions

RM := rm -rf

.PHONY: help pdf clean

help:
	@ echo "Usage:"
	@ echo "    make pdf      Build the PDF."
	@ echo "    make clean    Delete auxiliary files."
	@ echo "    make help     View these usage instructions."

pdf: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex
	$(LATEXMK) $(LATEXMKFLAGS) -pdflatex="$(LATEX) $(LATEXFLAGS) %O %S" $<

clean:
	$(LATEXMK) -C
	$(RM) *.bbl
	$(RM) *.run.xml
	$(RM) *."synctex(busy)"
