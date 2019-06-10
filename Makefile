SHELL := /bin/bash

annotation.pdf: annotation.odt
	soffice --headless --convert-to pdf annotation.odt
	
specification.pdf: specification.odt
	soffice --headless --convert-to pdf specification.odt
	
title.pdf: annotation.odt
	soffice --headless --convert-to pdf title.odt
	
thesis.pdf: thesis.odt
	soffice --headless --convert-to pdf thesis.odt
	
thesis-full.pdf: thesis.pdf title.pdf specification.pdf annotation.pdf
	pdftk title.pdf specification.pdf annotation.pdf thesis.pdf cat output thesis-full.pdf

thesis-samarin.pdf: 
	bash create-antiplagiat-pdf.sh

all: thesis-full.pdf thesis-samarin.pdf

clean:
	rm -f title.pdf specification.pdf annotation.pdf thesis.pdf thesis-full.pdf thesis-samarin.pdf

