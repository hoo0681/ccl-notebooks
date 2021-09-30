FROM jupyter/scipy-notebook:latest
LABEL Name=notebooks Version=0.0.1
#RUN apt-get -y update && apt-get install -y fortunes
RUN mamba install --quiet --yes \
    'jupyterlab-drawio'\
    'jupyterlab-git' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
# Install facets which does not have a pip or conda package at the moment
#WORKDIR /tmp
#RUN git clone https://github.com/PAIR-code/facets.git && \
#    jupyter nbextension install facets/facets-dist/ --sys-prefix && \
#    rm -rf /tmp/facets && \
#    fix-permissions "${CONDA_DIR}" && \
#    fix-permissions "/home/${NB_USER}"
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"
    
USER ${NB_UID}

WORKDIR "${HOME}"
#docker build -t hoo0681/test-ccl-notebook:<tag> .
#docker push hoo0681/test-ccl-notebook:<tag>