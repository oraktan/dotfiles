#!/usr/bin/env bash
set -e

# Çıktı adı
TARIH=$(date +"%Y-%m-%d_%H-%M-%S")
FINAL_PDF="birlesik_$TARIH.pdf"
TMP_MERGED="tmp_merged_$TARIH.pdf"

# Listeleri tanımla
G_LIST=()
P_LIST=()

# Dosyaları tara
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

# Görselleri A4'e sığacak şekilde PDF'e çevir
TMP_IMG=""
if [ ${#G_LIST[@]} -gt 0 ]; then
    TMP_IMG="tmp_imgs_$TARIH.pdf"
    img2pdf --pagesize A4 --fit into "${G_LIST[@]}" -o "$TMP_IMG"
    P_LIST+=("$TMP_IMG")
fi

# Birleştir
if [ ${#P_LIST[@]} -gt 0 ]; then
    pdfunite "${P_LIST[@]}" "$TMP_MERGED"
    [ -f "$TMP_IMG" ] && rm "$TMP_IMG"

    # Tüm sayfaları orantıyı (aspect ratio) bozmadan A4'e zorla
    gs -o "$FINAL_PDF" \
       -sDEVICE=pdfwrite \
       -dDEVICEWIDTHPOINTS=595 \
       -dDEVICEHEIGHTPOINTS=842 \
       -dFIXEDMEDIA \
       -dPDFFitPage \
       -dUseCropBox \
       -dAutoRotatePages=/None \
       -dCompatibilityLevel=1.4 \
       -dNOPAUSE -dBATCH \
       "$TMP_MERGED"

    rm "$TMP_MERGED"
    echo "✔️ Başarılı: $FINAL_PDF"
else
    echo "❌ Hata: Uygun dosya seçilmedi."
    exit 1
fi
