#!/bin/bash

# Создание локального репозитория
svnadmin create repo
REPO_URL="file://$(pwd)/repo"


# Создаём структуру проекта
cd repo
svn mkdir -m "project structure" $REPO_URL/trunk $REPO_URL/branches
cd ..

# Создание рабочей копии
svn checkout $REPO_URL/trunk/ wc
cd wc


# Начальная ревизия (пользователь 1) {
unzip -o ../commits/commit0.zip -d .
svn add *
svn commit -m "Initial commit (r0)" --username=red
# }


# Ревизия r1 (пользователь 1) {
# Удаляем файлы из рабочей директории
# (если это не сделать, то `... is already under version control`)
svn rm *
unzip -o ../commits/commit1.zip -d .
svn add *
svn commit -m "Revision 1 (r1)" --username=red
# }


# Ревизия r2 (пользователь 1) {
svn rm *
unzip -o ../commits/commit2.zip -d .
svn add *
svn commit -m "Revision 2 (r2)" --username=red
# }


# Ревизия r3 (пользователь 2) {
svn copy $REPO_URL/trunk $REPO_URL/branches/branch2 -m "Creating branch2"
svn switch $REPO_URL/branches/branch2

svn rm *
unzip -o ../commits/commit3.zip -d .
svn add *
svn commit -m "Revision 3 (r3)" --username=blue
# }


# Ревизия r4 (пользователь 1) {
svn switch $REPO_URL/trunk
svn rm *
unzip -o ../commits/commit4.zip -d .
svn add *
svn commit -m "Revision 4 (r4)" --username=red
# }


# Ревизии r5-r6 (пользователь 2) {
svn switch $REPO_URL/branches/branch2

svn rm *
unzip -o ../commits/commit5.zip -d .
svn add *
svn commit -m "Revision 5 (r5)" --username=blue

svn rm *
unzip -o ../commits/commit6.zip -d .
svn add *
svn commit -m "Revision 6 (r6)" --username=blue
# }


# Ревизия r7 (пользователь 1) {
svn switch $REPO_URL/trunk
svn rm *
unzip -o ../commits/commit7.zip -d .
svn add *
svn commit -m "Revision 7 (r7)" --username=red
# }


# Ревизия r8 (пользователь 2) {
svn switch $REPO_URL/branches/branch2

svn rm *
unzip -o ../commits/commit8.zip -d .
svn add *
svn commit -m "Revision 8 (r8)" --username=blue
# }

svn update

# Ревизия r9 (пользователь 1) {
svn copy $REPO_URL/branches/branch2 $REPO_URL/branches/branch3 -m "Creating branch3"
svn switch $REPO_URL/branches/branch3

svn rm * --force

svn merge $REPO_URL/branches/branch2

unzip -o ../commits/commit9.zip -d .
svn add *
svn commit -m "Revision 9 (r9)" --username=red
# }

svn update

# Ревизии r10-r11 (пользователь 1) {
svn switch $REPO_URL/trunk

svn rm *
unzip -o ../commits/commit10.zip -d .
svn add *
svn commit -m "Revision 10 (r10)" --username=red

svn rm *
unzip -o ../commits/commit11.zip -d .
svn add *
svn commit -m "Revision 11 (r11)" --username=red
# }


# Ревизия r12 (пользователь 1) {
svn switch $REPO_URL/branches/branch3

svn rm *
unzip -o ../commits/commit12.zip -d .
svn add *
svn commit -m "Revision 12 (r12)" --username=red
# }


svn update

# Мердж ревизии r11 с r12 {
svn switch $REPO_URL/trunk
svn merge $REPO_URL/branches/branch3

nano Lab4.java
svn resolved Lab4.java
# }

# Ревизии r13-r14 (пользователь 1) {
svn rm * --force
unzip -o ../commits/commit13.zip -d .
svn add *
svn commit -m "Revision 13 (r13)" --username=red

svn rm *
unzip -o ../commits/commit14.zip -d .
svn add *
svn commit -m "Revision 14 (r14)" --username=red
# }

svn update
