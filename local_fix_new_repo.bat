@echo off
REM Remove existing remote origin
git remote remove origin

REM Add new remote origin
git remote add origin https://github.com/KytraScript/cmon-wombo-lets-chat.git

REM Checkout a specific branch
git checkout local_install

REM Fetch and pull the newest changes
git fetch
git pull origin local_install

echo Completed successfully.
pause