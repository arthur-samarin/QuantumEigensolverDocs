#!/usr/bin/env bash
TMP=$(mktemp -d)
echo $TMP
TITLE_TMP="$TMP/01-title"
SPECIFICATION_TMP="$TMP/02-specification"
ANNOTATION_TMP="$TMP/03-annotation"

mkdir "$TITLE_TMP" "$SPECIFICATION_TMP" "$ANNOTATION_TMP" 

pdftk title.pdf burst output "$TITLE_TMP/%04d.pdf"
pdftk annotation.pdf burst output "$ANNOTATION_TMP/%04d.pdf"
pdftk specification.pdf burst output "$SPECIFICATION_TMP/%04d.pdf"

for PAGE_PDF in $TMP/*/*.pdf
do
  echo "Making $PAGE_PDF an image"
  convert -density 300 $PAGE_PDF $PAGE_PDF.jpg
  rm $PAGE_PDF
  convert $PAGE_PDF.jpg $PAGE_PDF
done

pdftk $TITLE_TMP/*.pdf $SPECIFICATION_TMP/*.pdf $ANNOTATION_TMP/*.pdf thesis.pdf cat output thesis-samarin.pdf

