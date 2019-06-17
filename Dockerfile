FROM tensorflow/tensorflow:1.13.1-gpu-py3

RUN apt-get update

# Install common tools
RUN apt-get install -y git tmux htop vim wget

# Install oh-my-zsh
RUN apt-get install -y zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Install jupyterlab
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install jupyterlab
RUN cd /root
RUN mkdir .jupyter
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN nodejs -v

# Install Python Packages & Requirements (Done near end to avoid invalidating cache)
RUN cd /
COPY requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt
RUN rm requirements.txt
RUN jupyter nbextension enable --py widgetsnbextension
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager


EXPOSE 8888
RUN mkdir workspace
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/workspace --allow-root

