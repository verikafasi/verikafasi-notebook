# Choose your desired base image
FROM jupyter/r-notebook

ARG conda_env=python36
ARG py_ver=3.6

RUN conda create --quiet --yes -p $CONDA_DIR/envs/$conda_env python=$py_ver ipython ipykernel  gcc_linux-64 gxx_linux-64 pystan && \
    conda clean --all -f -y

RUN $CONDA_DIR/envs/${conda_env}/bin/python -m ipykernel install --user --name=${conda_env} && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN rm -rf /home/$NB_USER/work && \
    fix-permissions /home/$NB_USER
