#!/bin/make

.PHONY: all run clean
.DEFAULT: all

all: run

run: SEIRD.pdf
	xdg-open $^

%.pdf: %.tex
	pdflatex $^

%.tex: %.dot
	dot2tex --prog=dot --preproc -traw --autosize --crop $^ > $@

clean:
	rm *.tex *.log *.aux *.pdf
