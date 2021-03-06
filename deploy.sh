#!/usr/bin/env sh

# остановить публикацию при ошибках
set -e

# сборка
npm run build

# переход в каталог сборки
cd distgit

git init
git add -A
git commit -m 'deploy'

# если вы публикуете по адресу https://<USERNAME>.github.io
# git push -f git@github.com:lapinmark/lapinmark.github.io.git master

# если вы публикуете по адресу https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:lapinmark/taxesvue.git master:gh-pages

cd -