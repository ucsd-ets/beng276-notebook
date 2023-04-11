FROM ucsdets/scipy-ml-notebook:2023.2-stable

USER root

# https://pdb2pqr.readthedocs.io/en/latest/getting.html#python-package-installer-pip
RUN pip install pdb2pqr

# https://apbs.readthedocs.io/en/latest/getting/index.html#installing-from-pre-compiled-binaries
# https://github.com/Electrostatics/apbs/releases
#RUN pwd && \
#    cd /opt && \
#    wget https://github.com/Electrostatics/apbs/releases/download/v3.0.0/APBS-3.0.0_Linux.zip && \
#    unzip APBS-3.0.0_Linux.zip && \
#    mv APBS-3.0.0_Linux apbs && \
#    chown -R $NB_UID apbs
#    rm APBS-3.0.0_Linux.zip

ARG BROWNDYE_VERSION=20.04-2023-01-25

# https://browndye.ucsd.edu/download.html#gnu-linux
RUN apt-get update -y && \
    apt-get install -y ocaml libexpat-dev liblapack-dev && \
    apt-get install -y libexpat1 make apbs && \
    cd /opt && \
    wget https://browndye.ucsd.edu/downloads/browndye2-ubuntu-$BROWNDYE_VERSION.tar.gz && \
    tar zxvf browndye2-ubuntu-$BROWNDYE_VERSION.tar.gz && \
    chown -R $NB_UID browndye2 && \
    rm browndye2-ubuntu-$BROWNDYE_VERSION.tar.gz

env PATH=/opt/browndye2/bin:$PATH

USER $NB_UID
