#!/usr/bin/env bash
# Переключает сайт с github.io на кастомный домен за один проход.
# Использование: bash scripts/set-domain.sh pereezdnayug.ru
# После: git add -A && git commit && git push  →  и в Settings→Pages указать Custom domain.
set -euo pipefail
DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then echo "Укажи домен: bash scripts/set-domain.sh pereezdnayug.ru"; exit 1; fi
OLD="ivanintouch-labs.github.io"

cd "$(dirname "$0")/.."

# 1) Заменить базовый URL во всех canonical/og/sitemap/robots/llms/breadcrumb
grep -rl "$OLD" . --include="*.html" --include="*.xml" --include="*.txt" 2>/dev/null \
  | grep -v "/scripts/" \
  | while read -r f; do
      sed -i '' "s#https://$OLD#https://$DOMAIN#g" "$f"
      sed -i '' "s#$OLD#$DOMAIN#g" "$f"
    done

# 2) CNAME для GitHub Pages
echo "$DOMAIN" > CNAME

# 3) Обновить HOST в indexnow.sh
sed -i '' "s#^HOST=.*#HOST=\"$DOMAIN\"#" scripts/indexnow.sh

echo "Готово. Базовый URL → https://$DOMAIN, создан CNAME, обновлён indexnow HOST."
echo "Осталось: git add -A && git commit -m 'Connect domain $DOMAIN' && git push,"
echo "затем GitHub → Settings → Pages → Custom domain = $DOMAIN, дождаться HTTPS-сертификата."
