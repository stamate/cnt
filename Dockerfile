# syntax = docker/dockerfile:latest
ARG BASE=ubuntu:22.04

# FROM ubuntu:22.04
FROM ${BASE}

RUN apt-get update && apt-get install -y curl zsh git nano tmux build-essential python3-dev python3-pip

# Add tmux config
WORKDIR /root
RUN curl -O https://gist.githubusercontent.com/stamate/6dc1febded0ffde8816a2daa2c684d9f/raw/51a546868a727131b555bbd6fa6f311028009ff3/.tmux.conf

# Install Jupyter and extensions
RUN pip install --upgrade pip
RUN pip install notebook \
    nbdime \
    jupytext \
    ipython-autotime \
    autopep8 \
    jupyter_contrib_nbextensions \
    jupyter_nbextensions_configurator

# Jupyer configurations
RUN mkdir -p /root/.jupyter
RUN <<EOF cat >> /root/.jupyter/jupyter_notebook_config.py
c = get_config()
c.NotebookApp.allow_remote_access = True
c.NotebookApp.allow_root = True
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
c.NotebookApp.password = u'sha1:b4e4e0deb244:a8b99d99395ec48ea1d22e0ed3f2773d268cf5c0'
c.ContentsManager.allow_hidden = True
c.NotebookApp.port = 8899
c.NotebookApp.notebook_dir = "./"
c.NotebookApp.open_browser = False
c.NotebookApp.allow_root = True
c.NotebookApp.iopub_msg_rate_limit = 100000000
c.NotebookApp.iopub_data_rate_limit = 2147483647
c.NotebookApp.port_retries = 0
c.NotebookApp.quit_button = False
c.NotebookApp.allow_remote_access = True
c.NotebookApp.disable_check_xsrf = True
c.NotebookApp.allow_origin = "*"
c.NotebookApp.trust_xheaders = True
c.MappingKernelManager.buffer_offline_messages = True
c.Application.log_level = "WARN"
c.NotebookApp.log_level = "WARN"
c.JupyterApp.answer_yes = True
c.FileContentsManager.delete_to_trash = False
c.IPKernelApp.matplotlib = "inline"
EOF

# Enable jupyter extensions
RUN \
    jupyter contrib nbextension install --sys-prefix && \
    # nbextensions configurator
    jupyter nbextensions_configurator enable --sys-prefix && \
    # Configure nbdime
    nbdime config-git --enable --global && \
    # Activate Jupytext
    jupyter nbextension enable --py jupytext --sys-prefix && \
    # Enable useful extensions
    jupyter nbextension enable skip-traceback/main --sys-prefix && \
    # jupyter nbextension enable comment-uncomment/main && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable execute_time/ExecuteTime --sys-prefix && \
    jupyter nbextension enable collapsible_headings/main --sys-prefix && \
    jupyter nbextension enable codefolding/main --sys-prefix && \
    jupyter nbextension enable code_prettify/autopep8 --sys-prefix

# Add on-my-zsh
RUN curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh || tru
RUN echo 'export LC_ALL=C.UTF-8' >> ~/.zshrc
RUN echo 'export LANG=C.UTF-8' >> ~/.zshrc
ENV SHELL /bin/zsh

WORKDIR /lab
EXPOSE ${PORT}

CMD ["jupyter", "notebook"]
