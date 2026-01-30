#!/usr/bin/env bash

set -e

TARIH=$(date +"%Y-%m-%d_%H-%M-%S")
FINAL_PDF="secili_dosyalar_$TARIH.pdf"

JPEG_LIST=()
PDF_LIST=()

for FILE in "$@"; do
  case "${FILE,,}" in
    *.jpg|*.jpeg)
      JPEG_LIST+=("$FILE")
      ;;
    *.pdf)
      PDF_LIST+=("$FILE")
      ;;
  esac
done

# JPEG varsa PDF'e çevir
if [ ${#JPEG_LIST[@]} -gt 0 ]; then
  IMG_PDF="$(dirname "${JPEG_LIST[0]}")/fotograflar_tmp_$TARIH.pdf"
  img2pdf "${JPEG_LIST[@]}" -o "$IMG_PDF"
  PDF_LIST+=("$IMG_PDF")
fi

# PDF'leri birleştir
if [ ${#PDF_LIST[@]} -gt 0 ]; then
  pdfunite "${PDF_LIST[@]}" "$FINAL_PDF"
fi
