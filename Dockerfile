FROM ucsdets/scipy-ml-notebook:2021.1-stable

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

# https://browndye.ucsd.edu/download.html#gnu-linux
RUN apt-get update -y && \
    apt-get install -y libexpat1 make apbs && \
    cd /opt && \
    wget https://browndye.ucsd.edu/downloads/browndye2-ubuntu-20.04-2021-01-08.tar.gz && \
    tar zxvf browndye2-ubuntu-20.04-2021-01-08.tar.gz && \
    chown -R $NB_UID browndye2 && \
    rm browndye2-ubuntu-20.04-2021-01-08.tar.gz

env PATH=/opt/browndye2/bin:$PATH

USER $NB_UID
