#!/bin/bash

# Очистка ненужных данных и backup .git
cp -r .git .rotter
cp .gitignore .rotterignore

rm -rf .git
rm -f .gitignore
echo "- Создан бэкап .git"

find src -type f ! -name '.keep' -delete
echo "- src очищен"


# Создание репозитория и начальная ревизия (r0)
git init
echo "- git init"


# Настройка .git/config
echo -e "\n[merge]\n\ttool = nano" >> .git/config


# Настройка пользователей
git config user.name "red"
git config user.email "red@example.com"
echo "- Пользователь red создан"


git checkout -b branch1

# Новый .gitignore {
echo ".resources" > .gitignore
echo ".rotter" >> .gitignore
echo "commits" >> .gitignore
echo "docs" >> .gitignore
echo "src/.keep" >> .gitignore
echo ".editorconfig" >> .gitignore
echo ".rotterignore" >> .gitignore
echo "git.sh" >> .gitignore
echo "svn.sh" >> .gitignore
echo ".gitattributes" >> .gitignore
echo "LICENSE" >> .gitignore
echo "README.md" >> .gitignore
echo "return-my-git-plz.sh" >> .gitignore
git add .gitignore
echo "- Новый .gitignore создан"
# }

# Ревизия r0 (пользователь 1) {
unzip -o commits/commit0.zip -d src
git add .
git commit -m "Initial commit (r0)"
echo "- Коммит 0 (red)"
# }


# Ревизии r1-r2 (пользователь 1) {
unzip -o commits/commit1.zip -d src
git add .
git commit -m "Revision 1 (r1)"
echo "- Коммит 1 (red)"

unzip -o commits/commit2.zip -d src
git add .
git commit -m "Revision 2 (r2)"
echo "- Коммит 2 (red)"
# }


# Ревизия r3 (пользователь 2) {
git checkout -b branch2

unzip -o commits/commit3.zip -d src
git add .
git commit --author="blue <blue@example.com>" -m "Revision 3 (r3)"
echo "- Коммит 3 (blue)"
# }


# Ревизия r4 (пользователь 1) {
git checkout branch1

unzip -o commits/commit4.zip -d src
git add .
git commit -m "Revision 4 (r4)"
echo "- Коммит 4 (red)"
# }


# Ревизии r5-r6 (пользователь 2) {
git checkout branch2

unzip -o commits/commit5.zip -d src
git add .
git commit --author="blue <blue@example.com>" -m "Revision 5 (r5)"
echo "- Коммит 5 (blue)"

unzip -o commits/commit6.zip -d src
git add .
git commit --author="blue <blue@example.com>" -m "Revision 6 (r6)"
echo "- Коммит 6 (blue)"
# }


# Ревизия r7 (пользователь 1) {
git checkout branch1

unzip -o commits/commit7.zip -d src
git add .
git commit -m "Revision 7 (r7)"
echo "- Коммит 7 (red)"
# }


# Ревизия r8 (пользователь 2) {
git checkout branch2

unzip -o commits/commit8.zip -d src
git add .
git commit --author="blue <blue@example.com>" -m "Revision 8 (r8)"
echo "- Коммит 8 (blue)"
# }


# Ревизия r9 {
git checkout -b branch3

# Создание файла для ревизии r9 с участием обоих пользователей
unzip -o commits/commit9.zip -d src
git add .
git commit -m "Revision 9 (r9)"
echo "- Коммит 9 (red)"

git checkout branch2
git merge --ff-only branch3
# }


# Ревизии r10-r11 (пользователь 1) {
git checkout branch1

unzip -o commits/commit10.zip -d src
git add .
git commit -m "Revision 10 (r10)"
echo "- Коммит 10 (red)"

unzip -o commits/commit11.zip -d src
git add .
git commit -m "Revision 11 (r11)"
echo "- Коммит 11 (red)"
# }


# Ревизии r12 {
git checkout branch3

unzip -o commits/commit12.zip -d src
git add .
git commit -m "Revision 12 (r12)"
echo "- Коммит 12 (red)"
# }


# Мердж ревизии r11 с r12 # {
git checkout branch1

# Эта опция сохранит вашу версию файла (ветку, из которой выполняется слияние) в случае конфликта
# git merge --no-commit branch3 -Xours

# Эта опция сохранит версию файла из ветки, с которой выполняется слияние, в случае конфликта
# git merge --no-commit branch3 -Xtheirs

git merge --no-commit branch3


##
## ИСПРАВЛЕНИЕ КОНФЛИКТА ВРУЧНУЮ
##

git add .
echo "- Слияние r11 и r12"

# Отменяем merge в случае отмены
# git merge --abort


# Ревизии r13-r14 (пользователь 1) {
unzip -o commits/commit13.zip -d src
git add .
git commit -m "Revision 13 (r13)"
echo "- Коммит 13 (red)"

unzip -o commits/commit14.zip -d src
git add .
git commit -m "Revision 14 (r14)"
echo "- Коммит 14 (red)"
# }

# Вывод графа
git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all
