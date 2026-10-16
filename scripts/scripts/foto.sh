#!/usr/bin/env bash
set -e

# Kullanım: ./4lu_kart.sh sol_ust.jpg sag_ust.jpg sol_alt.jpg sag_alt.jpg [cikti.pdf]
if [ "$#" -lt 4 ]; then
    echo "❌ Kullanım: $0 sol_ust sag_ust sol_alt sag_alt [cikti.pdf]"
    echo "   (4 görsel/PDF dosyası gerekli — sırasıyla: sol üst, sağ üst, sol alt, sağ alt)"
    exit 1
fi

SOL_UST="$1"
SAG_UST="$2"
SOL_ALT="$3"
SAG_ALT="$4"
CIKTI="${5:-kartlar_$(date +"%Y-%m-%d_%H-%M-%S").pdf}"

# A4, 300 DPI: 2480x3508 px
DPI=300
SAYFA_W=2480
SAYFA_H=3508

# Her hücre için kenar boşluğu bırakarak alan (yatay 2, dikey 2 hücre)
MARGIN=40
HUCRE_W=$(( (SAYFA_W / 2) - (MARGIN * 2) ))
HUCRE_H=$(( (SAYFA_H / 2) - (MARGIN * 2) ))

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# Her görseli/pdf'i hücreye sığacak şekilde (oranı bozmadan) küçült
prepare() {
    local SRC="$1"
    local OUT="$2"
    convert -density "$DPI" "$SRC[0]" -colorspace sRGB \
        -resize "${HUCRE_W}x${HUCRE_H}" \
        -background white -gravity center \
        -extent "${HUCRE_W}x${HUCRE_H}" \
        "$OUT"
}

prepare "$SOL_UST" "$TMPDIR/1.png"
prepare "$SAG_UST" "$TMPDIR/2.png"
prepare "$SOL_ALT" "$TMPDIR/3.png"
prepare "$SAG_ALT" "$TMPDIR/4.png"

# Boş A4 tuval oluştur ve 4 görseli yerleştir
convert -size "${SAYFA_W}x${SAYFA_H}" xc:white \
    "$TMPDIR/1.png" -geometry "+${MARGIN}+${MARGIN}" -composite \
    "$TMPDIR/2.png" -geometry "+$(( SAYFA_W/2 + MARGIN ))+${MARGIN}" -composite \
    "$TMPDIR/3.png" -geometry "+${MARGIN}+$(( SAYFA_H/2 + MARGIN ))" -composite \
    "$TMPDIR/4.png" -geometry "+$(( SAYFA_W/2 + MARGIN ))+$(( SAYFA_H/2 + MARGIN ))" -composite \
    -density "$DPI" -units PixelsPerInch \
    "$CIKTI"

echo "✔️ Başarılı: $CIKTI"
