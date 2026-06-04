#!/usr/bin/env bash
# Мгновенно уведомляет Яндекс/IndexNow об обновлённых URL (быстрее попадание в индекс).
# Использование: bash scripts/indexnow.sh   (шлёт все страницы из списка ниже)
set -euo pipefail
HOST="pereezdnayug.ru"
KEY="62084b643325fcec096f34a779e32185"
KEY_LOCATION="https://$HOST/$KEY.txt"
URLS='[
  "https://'$HOST'/",
  "https://'$HOST'/guides/distancionnaya-pokupka-kvartiry-v-krasnodare.html",
  "https://'$HOST'/guides/semeynaya-ipoteka-vozrast-detey-krasnodare.html",
  "https://'$HOST'/guides/materinskiy-kapital-pervonachalnyy-vznos-krasnodare.html",
  "https://'$HOST'/guides/kupit-kvartiru-za-schet-prodazhi-svoey.html",
  "https://'$HOST'/guides/bron-kvartiry-v-novostroyke-krasnodare.html"
]'
curl -sS -X POST "https://yandex.com/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"host\":\"$HOST\",\"key\":\"$KEY\",\"keyLocation\":\"$KEY_LOCATION\",\"urlList\":$URLS}" \
  -w "\nHTTP %{http_code}\n"
