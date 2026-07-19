#!/usr/bin/env bash
set -e

TARIH=$(date +"%Y-%m-%d_%H-%M-%S")
MERGED_PDF="tmp_merged_$TARIH.pdf"
FINAL_PDF="birlesik_a4_$TARIH.pdf"

G_LIST=()
P_LIST=()

for FILE in "$@"; do
    if [[ -f "$FILE" ]]; then
        EXT="${FILE##*.}"
        EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')
        case "$EXT_LOWER" in
            jpg|jpeg|png|webp)
                G_LIST+=("$FILE")
                ;;
            pdf)
                P_LIST+=("$FILE")
                ;;
        esac
    fi
done

TMP_IMG=""
if [ ${#G_LIST[@]} -gt 0 ]; then
    TMP_IMG="tmp_imgs_$TARIH.pdf"
    # Görselleri A4'e sığdırarak PDF'e çevir
    img2pdf --pagesize A4 --fit=into "${G_LIST[@]}" -o "$TMP_IMG"
    P_LIST+=("$TMP_IMG")
fi

if [ ${#P_LIST[@]} -gt 0 ]; then
    pdfunite "${P_LIST[@]}" "$MERGED_PDF"
    [ -f "$TMP_IMG" ] && rm "$TMP_IMG"

    # Son adım: TÜM sayfaları (PDF kaynaklı olanlar dahil) A4'e sabitle
    gs -o "$FINAL_PDF" \
       -sDEVICE=pdfwrite \
       -sPAPERSIZE=a4 \
       -dFIXEDMEDIA \
       -dPDFFitPage \
       -dCompatibilityLevel=1.4 \
       "$MERGED_PDF"

    rm "$MERGED_PDF"
    echo "✔️ Başarılı: $FINAL_PDF"
else
    echo "❌ Hata: Uygun dosya seçilmedi."
    exit 1
fi
