FROM ghcr.io/ucsd-ets/scipy-ml-notebook:2024.2-stable

USER root

# https://pdb2pqr.readthedocs.io/en/latest/getting.html#python-package-installer-pip
RUN pip install pdb2pqr

# https://apbs.readthedocs.io/en/latest/getting/index.html#installing-from-pre-compiled-binaries
# https://github.com/Electrostatics/apbs/releases
# 3.4.1 Website 
ARG APBS_VERSION=3.4.1

RUN pwd && \
    cd /opt && \
    wget https://github.com/Electrostatics/apbs/releases/download/v$APBS_VERSION/APBS-$APBS_VERSION.Linux.zip && \
    unzip APBS-$APBS_VERSION.Linux.zip && \
    mv APBS-$APBS_VERSION.Linux apbs && \
    chown -R $NB_UID apbs && \
    rm APBS-$APBS_VERSION.Linux.zip
    

env PATH=/opt/apbs/bin:$PATH
env PATH=/opt/apbs/share/apbs/tools/bin:$PATH


ARG BROWNDYE_VERSION=20.04-2023-01-25

# https://browndye.ucsd.edu/download.html#gnu-linux
RUN apt-get update -y && \
    apt-get install -y ocaml libexpat-dev liblapack-dev && \
    apt-get install -y libexpat1 make && \
    cd /opt && \
    wget https://browndye.ucsd.edu/downloads/browndye2-ubuntu-$BROWNDYE_VERSION.tar.gz && \
    tar zxvf browndye2-ubuntu-$BROWNDYE_VERSION.tar.gz && \
    chown -R $NB_UID browndye2 && \
    conda init bash && \
    exec bash && \
    rm browndye2-ubuntu-$BROWNDYE_VERSION.tar.gz

env PATH=/opt/browndye2/bin:$PATH

RUN conda install -c conda-forge openmm cudatoolkit=11.2

USER $NB_UID
