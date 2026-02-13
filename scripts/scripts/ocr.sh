#!/bin/bash
# Seçilen alanı geçici bir dosyaya kaydetmeden doğrudan işle
SELECTION=$(slurp)
if [ -n "$SELECTION" ]; then
    grim -g "$SELECTION" - | tesseract - stdout -l tur+eng | wl-copy
    notify-send "OCR Başarılı" "Metin başarıyla panoya kopyalandı." -i edit-paste
fi
