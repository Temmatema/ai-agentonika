# АгентникАи — лендинг «ИИ-агенты для бизнеса»

Статический лендинг (HTML + CSS + JS, без сборки и зависимостей).

## Структура

```
index.html          — разметка страницы
style.css           — стили
script.js           — скрипты (плавающая навигация, анимации)
assets/
  robot.png         — изображение робота (hero)
  robot.svg         — векторная версия
.nojekyll           — отключает Jekyll при публикации на GitHub Pages
```

## Локальный запуск

Просто откройте `index.html` в браузере. Либо поднимите локальный сервер:

```powershell
# Python
python -m http.server 5500

# или Node
npx serve .
```

Затем откройте http://localhost:5500

## Публикация на GitHub Pages

Сайт переезжает без правок: все ссылки относительные, поэтому он корректно
работает и по адресу `https://<user>.github.io/<repo>/`.

### Вариант A — через git

```powershell
git init
git add .
git commit -m "Initial commit: AI-agents landing page"
git branch -M main
git remote add origin https://github.com/<USER>/<REPO>.git
git push -u origin main
```

Затем: **Settings → Pages → Build and deployment**
→ Source: *Deploy from a branch* → Branch: `main` → папка `/ (root)` → **Save**.

Сайт: `https://<USER>.github.io/<REPO>/` (появляется через ~1 минуту).

### Вариант B — без установки git (через веб-интерфейс)

1. github.com → **New repository** (Public, например `ai-site`).
2. **Add file → Upload files** → перетащите `index.html`, `style.css`,
   `script.js`, папку `assets/`.
3. **Add file → Create new file** → имя `.nojekyll` → **Commit**.
4. **Settings → Pages** → Source: *Deploy from a branch* → `main` / `/ (root)` → **Save**.

### Вариант C — GitHub Desktop

Установите [GitHub Desktop](https://desktop.github.com/), добавьте папку как
локальный репозиторий, сделайте commit и **Publish repository**, затем включите
Pages как в варианте A.
