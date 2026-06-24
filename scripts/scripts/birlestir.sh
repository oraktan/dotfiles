#!/usr/bin/env bash
set -e

# Gerekli bağımlılık kontrolü (pdfjam)
if ! command -v pdfjam &> /dev/null; then
    echo "❌ Hata: 'pdfjam' sistemde bulunamadı."
    echo "Lütfen kurun (Fedora: sudo dnf install texlive-pdfjam | Arch/CachyOS: sudo pacman -S texlive-pdfjam)"
    exit 1
fi

# Çıktı adı
TARIH=$(date +"%Y-%m-%d_%H-%M-%S")
FINAL_PDF="birlesik_$TARIH.pdf"
UNITE_PDF="tmp_unite_$TARIH.pdf"

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

# Görselleri PDF'e çevir (Doğrudan A4 boyutunda şablon oluşturur)
TMP_IMG=""
if [ ${#G_LIST[@]} -gt 0 ]; then
    TMP_IMG="tmp_imgs_$TARIH.pdf"
    img2pdf --pagesize A4 "${G_LIST[@]}" -o "$TMP_IMG"
    P_LIST+=("$TMP_IMG")
fi

# Birleştirme ve A4 Kalıbına Sokma İşlemi
if [ ${#P_LIST[@]} -gt 0 ]; then
    # Eğer tek bir PDF varsa ve görsel yoksa doğrudan pdfjam'e sokabilmek için kontrol
    if [ ${#P_LIST[@]} -eq 1 ]; then
        pdfjam --paper a4paper --keepaspectratio true "${P_LIST[0]}" -o "$FINAL_PDF"
    else
        # Birden fazla PDF veya görsel varsa önce birleştir, sonra hepsini A4 yap
        pdfunite "${P_LIST[@]}" "$UNITE_PDF"
        pdfjam --paper a4paper --keepaspectratio true "$UNITE_PDF" -o "$FINAL_PDF"
        [ -f "$UNITE_PDF" ] && rm "$UNITE_PDF"
    fi

    # Geçici görsel PDF'ini temizle
    [ -f "$TMP_IMG" ] && rm "$TMP_IMG"
    
    echo "✔️ Başarılı: Tüm sayfalar A4 boyutuna sığdırıldı -> $FINAL_PDF"
else
    echo "❌ Hata: Uygun dosya seçilmedi."
    exit 1
fi
