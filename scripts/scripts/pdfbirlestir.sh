#!/usr/bin/env bash
set -e

# Çıktı adı
TARIH=$(date +"%Y-%m-%d_%H-%M-%S")
FINAL_PDF="birlesik_$TARIH.pdf"

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

# Görselleri A4 PDF'e çevir
TMP_IMG=""
if [ ${#G_LIST[@]} -gt 0 ]; then
    TMP_IMG="tmp_imgs_$TARIH.pdf"
    img2pdf "${G_LIST[@]}" \
        --pagesize A4 \
        --fit shrink \
        -o "$TMP_IMG"
    P_LIST+=("$TMP_IMG")
fi

# Birleştir
if [ ${#P_LIST[@]} -gt 0 ]; then
    pdfunite "${P_LIST[@]}" "$FINAL_PDF"
    [ -f "$TMP_IMG" ] && rm "$TMP_IMG"
    echo "✔️ Başarılı: $FINAL_PDF"
else
    echo "❌ Hata: Uygun dosya seçilmedi."
    exit 1
fi
