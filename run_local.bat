@echo off

call conda activate ./venv

REM Enable jupyter_http_over_ws jupyter extension
call jupyter serverextension enable --py jupyter_http_over_ws

REM Enable ipywidgets extension
call jupyter nbextension enable --py widgetsnbextension

REM Launch Jupyter notebook
call jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com' --port=8998 --NotebookApp.port_retries=0 --no-browser
