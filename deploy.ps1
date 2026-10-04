# deploy.ps1 — публикация лендинга на GitHub Pages (требуется установленный git)
#
# Пример:
#   .\deploy.ps1 -RepoUrl "https://github.com/<USER>/<REPO>.git"
#
param(
  [Parameter(Mandatory = $true)][string]$RepoUrl,   # https://github.com/<USER>/<REPO>.git
  [string]$Branch = 'main',
  [string]$Message = 'Update site',
  [string]$Name,                                    # автор коммита (git user.name)
  [string]$Email                                    # e-mail коммита (git user.email)
)

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host 'git не найден в PATH.' -ForegroundColor Red
  Write-Host 'Установите Git: https://git-scm.com/download/win' -ForegroundColor Yellow
  exit 1
}

if (-not (Test-Path '.git')) { git init }

# Автор коммита: если передали -Name / -Email, сохраняем в глобальный конфиг
if ($Name)  { git config --global user.name $Name }
if ($Email) { git config --global user.email $Email }

$uname = git config user.name
$uemail = git config user.email
if (-not $uname -or -not $uemail) {
  Write-Host 'Не задан автор коммита (user.name / user.email).' -ForegroundColor Red
  Write-Host 'Задайте их и повторите, например:' -ForegroundColor Yellow
  Write-Host '  git config --global user.name "Ваше Имя"'
  Write-Host '  git config --global user.email "you@example.com"'
  Write-Host 'Либо передайте параметры -Name и -Email этому скрипту.' -ForegroundColor Yellow
  exit 1
}

$changes = git status --porcelain
if ($changes) {
  git add .
  git commit -m $Message
  if ($LASTEXITCODE -ne 0) { Write-Host 'Не удалось создать commit.' -ForegroundColor Red; exit 1 }
} else {
  Write-Host 'Нет изменений для коммита — пропускаю.' -ForegroundColor Yellow
}

git branch -M $Branch

$remotes = @(git remote)
if ($remotes -notcontains 'origin') {
  git remote add origin $RepoUrl
} else {
  git remote set-url origin $RepoUrl
}

git push -u origin $Branch
if ($LASTEXITCODE -ne 0) { Write-Host 'Push не удался (проверьте авторизацию/доступ).' -ForegroundColor Red; exit 1 }

Write-Host ''
Write-Host 'Готово! Осталось включить Pages:' -ForegroundColor Green
Write-Host "  Settings -> Pages -> Source: Deploy from a branch -> $Branch / (root) -> Save"
Write-Host "  Сайт: <адрес репозитория без .git> -> https://<USER>.github.io/<REPO>/"
