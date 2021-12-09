chcp 65001
@echo off
rem ci-bot - пользователь хранилища 1С
rem gitsync --v8-path "D:\Anatoly\Program Files\1cv8\8.3.18.1698\bin\1cv8.exe" init -u ci-bot -p 12345 "D:\Anatoly\Bases\Курс DevOps\Storage" D:\Anatoly\repo\devops2021n\src\cf
rem gitsync --v8-path "D:\Anatoly\Program Files\1cv8\8.3.18.1698\bin\1cv8.exe" init -u ci-bot -p 12345 "D:\Anatoly\Bases\Курс DevOps\Storage" src/cf
gitsync --v8-path "D:\Anatoly\Program Files\1cv8\8.3.18.1698\bin\1cv8.exe" init -u ci-bot -p 12345 "D:\Anatoly\Bases\Курс DevOps\Storage" .\src\cf