FROM ucsdets/scipy-ml-notebook:2021.1-stable

USER root

# https://pdb2pqr.readthedocs.io/en/latest/getting.html#python-package-installer-pip
RUN pip install pdb2pqr

USER $NB_UID

# https://apbs.readthedocs.io/en/latest/getting/index.html#installing-from-pre-compiled-binaries
# https://github.com/Electrostatics/apbs/releases
RUN pwd && \
    cd /opt && \
    wget https://github.com/Electrostatics/apbs/releases/download/v3.0.0/APBS-3.0.0_Linux.zip && \
    unzip APBS-3.0.0_Linux.zip && \
    mv APBS-3.0.0_Linux apbs && \
    rm APBS-3.0.0_Linux.zip
