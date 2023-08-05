@echo off

REM set your environment name
set ENV_NAME=venv

REM set your python version
set PYTHON_VERSION=3.10

echo Creating environment %ENV_NAME% with Python %PYTHON_VERSION%
call conda create --prefix ./%ENV_NAME% python=%PYTHON_VERSION% -y

echo Activating environment %ENV_NAME%
call conda activate ./%ENV_NAME%

REM Install torch and torchvision
call pip install --upgrade torch==1.13.1 torchvision==0.14.1 --extra-index-url https://download.pytorch.org/whl/cu117

echo Installing dependencies...
call pip install -r requirements.txt

echo Installing git LFS for large model downloads...
call git lfs install

echo Cloning custom AnimateDiff library...
call git clone -b local_install https://github.com/KytraScript/cmon-wombo-lets-chat.git

echo Cloning required Stable Diffusion dependencies...
call git clone -b fp16 https://huggingface.co/runwayml/stable-diffusion-v1-5 AnimateDiff\models\StableDiffusion

echo Creating folder for motion models...
mkdir AnimateDiff\models\Motion_Module
mkdir AnimateDiff\models\Diffusion_Models

echo Cloning model repository from Kytra's Huggingface...
call git clone https://huggingface.co/kytr-ai/Custom_AnimateDiff

echo Moving models to respective folders within AnimateDiff...
move Custom_AnimateDiff\mm_sd_v14.ckpt AnimateDiff\models\Motion_Module\mm_sd_v14.ckpt
move Custom_AnimateDiff\mm_sd_v15.ckpt AnimateDiff\models\Motion_Module\mm_sd_v15.ckpt
move Custom_AnimateDiff\mistoonAnime_v20.safetensors AnimateDiff\models\Diffusion_Models\mistoonAnime_v20.safetensors

echo Cleaning up unnecessary directories from install path...
rmdir /S /Q Custom_AnimateDiff

echo Setting Jupyter start directory...
set WORKING_DIR=%~dp0
set WORKING_DIR=%WORKING_DIR:\=/%
call echo c.NotebookApp.notebook_dir = '%WORKING_DIR%' >> %USERPROFILE%/.jupyter/jupyter_notebook_config.py

echo Done.
pause
