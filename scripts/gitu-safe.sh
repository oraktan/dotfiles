#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/dotfiles"
cd "$REPO"

BRANCH="$(git symbolic-ref --quiet --short HEAD)" || {
    echo "HATA: Aktif branch bulunamadi."
    exit 1
}

echo "===== DOTFILES ====="
echo "Branch: $BRANCH"
git status --short

echo
echo "===== STAGED DOSYALAR ====="
git --no-pager diff --cached --stat

if ! git diff --cached --quiet; then
    read -r -p "Staged dosyalar commit edilsin mi? [y/N] " confirm

    if [[ "$confirm" != "y" ]]; then
        echo "Iptal edildi."
        exit 0
    fi

    message="${1:-dotfiles update}"
    git --no-pager commit -m "$message"
else
    echo "Yeni commit icin staged dosya yok."
fi

echo
read -r -p "Remote push kontrolu yapilsin mi? [y/N] " confirm

if [[ "$confirm" != "y" ]]; then
    echo "Push yapilmadi."
    exit 0
fi

echo "===== REMOTE GUNCELLENIYOR ====="
git fetch origin

REMOTE="refs/remotes/origin/$BRANCH"

if git show-ref --verify --quiet "$REMOTE"; then
    if ! git merge-base --is-ancestor "$REMOTE" HEAD; then
        echo "HATA: Remote branch ile yerel branch ayrismis."
        echo "Push engellendi. Once Git gecmisini incele."
        exit 1
    fi

    RANGE="$REMOTE..HEAD"
else
    echo "Remote branch henuz mevcut degil."
    RANGE="HEAD"
fi

echo
echo "===== GONDERILECEK COMMITLER ====="
git --no-pager log --oneline "$RANGE"

if [[ -z "$(git --no-pager log --format=%H "$RANGE")" ]]; then
    echo "Gonderilecek yeni commit yok."
    exit 0
fi

echo
read -r -p "Push icin PUSH yaz: " confirm

if [[ "$confirm" != "PUSH" ]]; then
    echo "Push iptal edildi."
    exit 0
fi

git push -u origin "$BRANCH"
