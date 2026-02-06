#!/usr/bin/env bash
set -u

CONFIG_DIR="$HOME/.config/Code/User/profiles"
mkdir -p "$CONFIG_DIR"

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
fi

shopt -s nullglob
profiles=( *.code-profile )

if [ ${#profiles[@]} -eq 0 ]; then
    echo "Aucun profil trouvé."
    exit 0
fi

for profile in "${profiles[@]}"; do
    dest="$CONFIG_DIR/$profile"
    if [ -f "$dest" ]; then
        echo "Profil $profile déjà présent, skip."
        continue
    fi

    if [ "$DRY_RUN" = true ]; then
        echo "(dry-run) Copie $profile → $CONFIG_DIR/"
    else
        cp "$profile" "$CONFIG_DIR/"
        echo "Copie terminée : $profile"
    fi
done

echo "Tous les profils ont été copiés."
